#!/usr/bin/env python 

import re, subprocess
def get_keychain_pass(account=None,server=None):
    params = {
            'security':  '/usr/bin/security',
            'command' :  'find-internet-password',
            'account' :  account,
            'server'  :  server,
            'keychain':  '/Users/ajay/Library/Keychains/login.keychain',
            }
    command = "sudo -u ajay {security} -v {command} -g -a {account} -s {server} {keychain}".format(**params)
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
            if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', outtext).group(1)

def local_nametrans(foldername):
    if(foldername.startswith('B-')):
        retval = re.sub('B-','mutt-archive/',foldername)
    else:
        retval = 'mutt/'+foldername
    return retval

def remote_nametrans(foldername):
    if(foldername.startswith('[Gmail]/')):
        retval = re.search(
        
    
