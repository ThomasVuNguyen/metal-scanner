import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () async{
      final stopwatch = Stopwatch();
      stopwatch.start();
      List<String> available_ip = await scan_network();
      List<String> authenticated_ip = await identify_rpi(
         // ['10.0.0.242', '10.0.0.243']
        available_ip
          , 'comfy.local','thomas', 'thomas');
      print('authenticated ip list: $authenticated_ip');
      stopwatch.stop();
      print('time elasped: ${stopwatch.elapsedMilliseconds / 1000}');
    });
  }
}

Future<List<String>> scan_network() async{
  List<String> ip_list = [];

  final info = NetworkInfo();
  final wifiIP = await info.getWifiIP();
  var subnet = ipToCSubnet(wifiIP!);
  print('subnet is $subnet');
  final scanner = LanScanner();
  print('scanning');

  final List<Host> hosts = await scanner.quickIcmpScanAsync(subnet);
  for(Host host in hosts){
    ip_list.add(host.internetAddress.address.toString());
    print('new host: ip ${host.internetAddress}, ping time ${host.pingTime}');
  }
  print(ip_list.toString());
  return ip_list;
}

Future<List<String>> identify_rpi(List<String> ip_list, String host_name,String username, String password) async{
  //authenticated & SSH-able devices
  List<String> authenticated_ip = [];
  //devices SSH-able, authenticated, and have matching hostname
  List<String> confirmed_ip = [];
  for (String ip in ip_list){
    print('authenticating $ip');
    try{
      SSHSocket socket = await SSHSocket.connect(ip, 22, timeout: const Duration(seconds: 1));
      var client = SSHClient(
          socket,
          username: username,
          onPasswordRequest: () => password,
          onAuthenticated: () {
            authenticated_ip.add(ip.trim());
            if (kDebugMode) {
              print('rpi found');
            }
          }
      );
      final command = await client.run('hostname');
      String device_hostname = utf8.decode(command).trim();
      print(device_hostname);
      if (host_name.contains(device_hostname) == true){
        confirmed_ip.add(ip);
      }

    } catch (e) {
      if (kDebugMode) {
      print('error with ssh connection: ${e.toString()}');
    }}
  }

  return confirmed_ip;
}

