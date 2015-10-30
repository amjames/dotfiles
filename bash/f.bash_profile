# ~/.bash_profile
#
echo "bash_profile here"
### START-keychain ###
/usr/bin/keychain $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOSTNAME-sh
### END-keychain ### 
source /etc/profile
