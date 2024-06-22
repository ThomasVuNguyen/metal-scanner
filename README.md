Sure, here is a polished version of your README.md file for GitHub:

# Metal Scanner

A tool for scanning Raspberry Pi devices on Wi-Fi or hotspot networks quickly and conveniently.

## Goal

1. Scan all devices on the network.
2. Identify if the device is a Raspberry Pi.
3. Find the device's IP address.

## Functionality Flow

1. **Determine Subnet IP Address:**
    - Identify the subnet IP address (e.g., `10.0.0`).

2. **Scan for Devices:**
    - Scan all devices within the subnet range (from addresses `10.0.0.1` to `10.0.0.255`).

3. **SSH Connection Attempt:**
    - Using a given hostname, username, and password, attempt SSH connections to all devices.
    - Compile a list of SSH-accessible devices with the correct username and password.

4. **(Optional) Hostname Verification:**
    - Execute the `hostname` bash command on the discovered devices to ensure the hostname matches the expected one.

5. **Return Matched IP Addresses:**
    - Return the IP addresses of all matched devices (typically only one machine).

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/metal-scanner.git
   ```
2. Run the installed repo in Android Studio or VSCode as a Flutter Project

## Requirements

- Flutter installed
- Android Studio / VSCode
- Android, iOS, Windows or Mac (for running the app, web doesn't support network scanning & ssh)


## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Contact

For any questions or inquiries, please contact [thomas@comfyspace.tech](mailto:thomas@comfyspace.tech).

---

By making these improvements, the README is now more organized, visually appealing, and easier to understand for users who visit your GitHub repository.