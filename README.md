# Home Assistant Auto Installer (Virtual Environment Configuration)

This script will install Home Assistant unattended.

1. Once completed, the various URLs + credentials are displayed at the end for your benefit to configure Home Assistant. It is recommended to change these immediately due to being shown in clear text.

2. Once everything has been installed and configured you will be able to immediately connect to Home Assistant using the URL and credentials as shown.

3. No support is provided and no liability is accepted in the event of adverse outcome with the use of the script. If you choose to use it, it is your responsibility to test it before using.

4. The script can be invoked using:

#### Ubuntu 16.04 LTS +
```bash
mkdir /home/homeassistant
cd /home/homeassistant
wget --no-cache -O ha-install https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/home-assistant-auto-install.bash && chmod +x ha-install && ./ha-install
```

## Copyright & Credit

### Home Assistant

Details of the Home Assistant Terms of Service can be found at: https://www.home-assistant.io/tos/