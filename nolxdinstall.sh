#!/bin/bash

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install figlet -y
figlet -t "Upgrading LXD Container"
sleep 2
sudo apt upgrade -y

figlet -t "Installing Python 3.11"
sleep 2
sudo apt install python3.11 -y
sudo apt install python3.11-venv -y
sudo apt autoremove -y

figlet -t "Creating Python venv"
sleep 2
/usr/bin/python3.11 -m venv /home/ubuntu/py311
echo "Done"
figlet -t "Adding LXD Devices"
sleep 2

echo .bash_profile
sudo curl -L -o /home/ubuntu/.bash_profile https://raw.githubusercontent.com/miklevin/lxdwin/main/.bash_profile
sudo chown ubuntu:ubuntu /home/ubuntu/.bash_profile
sudo chmod 777 /home/ubuntu/.bash_profile

echo .bash_prompt
sudo curl -L -o /home/ubuntu/.bash_prompt https://raw.githubusercontent.com/miklevin/lxdwin/main/.bash_prompt
sudo chown ubuntu:ubuntu /home/ubuntu/.bash_prompt
sudo chmod 777 /home/ubuntu/.bash_prompt

echo .screenrc
sudo curl -L -o /home/ubuntu/.screenrc https://raw.githubusercontent.com/miklevin/lxdwin/main/.screenrc
sudo chown ubuntu:ubuntu /home/ubuntu/.screenrc
sudo chmod 777 /home/ubuntu/.screenrc

echo ssh keys
sudo curl -L -o /home/ubuntu/repos/transfer/configure https://raw.githubusercontent.com/miklevin/lxdwin/main/config
sudo curl -L -o /home/ubuntu/repos/transfer/unrot.py https://raw.githubusercontent.com/miklevin/lxdwin/main/unrot.py
sudo curl -L -o /home/ubuntu/repos/transfer/pub.txt https://raw.githubusercontent.com/miklevin/lxdwin/main/pub.txt
sudo curl -L -o /home/ubuntu/repos/transfer/priv.txt https://raw.githubusercontent.com/miklevin/lxdwin/main/priv.txt
sudo curl -L -o /home/ubuntu/repos/transfer/known_hosts https://raw.githubusercontent.com/miklevin/lxdwin/main/known_hosts
sudo /home/ubuntu/py311/bin/python3.11 /home/ubuntu/repos/transfer/unrot.py --input /home/ubuntu/repos/transfer/pub.txt --output /home/ubuntu/repos/transfer/id_rsa_lxdwin.pub
sudo /home/ubuntu/py311/bin/python3.11 /home/ubuntu/repos/transfer/unrot.py --input /home/ubuntu/repos/transfer/priv.txt --output /home/ubuntu/repos/transfer/id_rsa_lxdwin

mv -n /home/ubuntu/repos/transfer/id_rsa_lxdwin.pub /home/ubuntu/.ssh
mv -n /home/ubuntu/repos/transfer/id_rsa_lxdwin /home/ubuntu/.ssh
mv -n /home/ubuntu/repos/transfer/known_hosts /home/ubuntu/.ssh
mv -n /home/ubuntu/repos/transfer/configure /home/ubuntu/.ssh

echo jupyterstart
sudo curl -L -o /usr/local/sbin/jupyterstart https://raw.githubusercontent.com/miklevin/lxdwin/main/jupyterstart
sudo chmod +x /usr/local/sbin/jupyterstart
echo jupyterscreen
sudo curl -L -o /usr/local/sbin/jupyterscreen https://raw.githubusercontent.com/miklevin/lxdwin/main/jupyterscreen
sudo chmod +x /usr/local/sbin/jupyterscreen

# figlet -t "Optional Installs"
# sleep 2
# sudo curl -L -o /usr/local/sbin/postinstall https://raw.githubusercontent.com/miklevin/lxdwin/main/postinstall
# sudo chmod +x /usr/local/sbin/postinstall
# postinstall
# sudo curl -L -o /home/ubuntu/repos/transfer/git_installs.sh https://raw.githubusercontent.com/miklevin/lxdwin/main/git_installs.sh

figlet -t "Installing JupyterLab"
sleep 2
/home/ubuntu/py311/bin/python3.11 -m pip install --upgrade pip
/home/ubuntu/py311/bin/python3.11 -m pip install jupyterlab
figlet -t "jupyter installed"
sleep 2
# lxc alias remove jupyterstart >/dev/null 2>&1
# lxc alias add jupyterstart "exec jupyter -- su --login ubuntu -c /usr/local/sbin/jupyterstart"
# lxc alias remove jupyterscreen >/dev/null 2>&1
# lxc alias add jupyterscreen "exec jupyter -- su --login ubuntu -c /usr/local/sbin/jupyterscreen"
# lxc alias remove jupyter >/dev/null 2>&1
# lxc alias add jupyterlogin "exec jupyter -- su --login ubuntu"
exit