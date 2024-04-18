# Server System Management - Linux part
To install the monitor server with the custom scripts, clone the entire repository and run the install-monitor-server.sh script
```bash
git clone https://github.com/Thiibo/ssm-linux.git
cd ssm-linux
chmod +x ./install-monitor-server.sh
./install-monitor-server.sh
```

To install the load balancers, only retreive the install-smtp.sh script and run it
```bash
wget https://raw.githubusercontent.com/Thiibo/ssm-linux/main/install-smtp.sh
chmod +x ./install-smtp.sh
./install-smtp.sh
```
