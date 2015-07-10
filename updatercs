#! /usr/bin/env python 

import sys 
import os 
import subprocess 
import re

#need to update this list as needed 
hosts = {
        'brlogin1':'blueridge',
        'brlogin2':'blueridge',
        'br':'blueridge',
        'Herbert-3.local':'herbert'
        }


# I hate forgetting to put these in '' 
mv = 'mv'
rm = 'rm'
cp = 'cp'
ls = 'ls'
cd = 'cd'


#This is where it should go (maybe the setup script will change that)
rc_repo_path = os.path.expanduser('~/Vault/dotfiles')

#get the home dir path
home = os.path.expanduser('~')
re_source=False
def hostname():
    brcompute = re.compile('^(br)[0-9]{1,3}$')
    a = subprocess.check_output(['hostname'])
    name = a.strip()
    if name in hosts.keys():
        return hosts[name]
    else:
        host = brcompute.search(name)
        return hosts[host.group(1)]



def bakup(path,test=False):
    if test:
        string = " ".join([cp, rc_repo, 'somthing else'])
        print string
    else:
        subprocess.check_output([cp, path, path+'.bak'])


def delbakup(path,test=False):
    if test:
        string = ' '.join([rm, path+'.bak'])
        print string
    else:
        subprocess.call([rm, path+'.bak'])

def update_report(rc_tgt, working_dict):
    try: 
        ret = subprocess.check_output([
        cp,
        isnewer(rc_tgt,working_dict),
        rc_tgt],stderr=subprocess.STDOUT)
        (x,y) = os.path.split(rc_tgt)
        (a,b) = os.path.split(working_dict)
        print '\t [rc-updater ==>] {} updated from repo, with {}'.format(y,b)
        re_source = True 
    except subprocess.CalledProcessError:
        (x,y) = os.path.split(rc_tgt)
        print '\t [rc-updater ==>] {} upto date!'.format(y)

def isnewer(path1,path2):
    n1 = os.path.getmtime(path1)
    n2 = os.path.getmtime(path2)
    if n2>n1:
        return path2
    else:
        return path1
def report():
    print '\t [rc-updater ==>] in ' + os.path.abspath('.')+":"

def update_repo():
    report()
    os.chdir(rc_repo_path)
    subprocess.call(['git','pull','origin','master'])
    os.chdir(home)
    report()

def unlock_rc(rcname):
    print "\t [rc-updater ==>] Checking {}".format(rcname)
    subprocess.call(
            ['chmod','644',os.path.join(home,rcname)]
            )
    return 

def lock_rc(rcname):
    print "\t [rc-updater ==>] Locking {}".format(rcname)
    subprocess.call(
            ['chmod','444',os.path.join(home,rcname)]
            )
    return 


def main(argv=None):
    update_repo()
    target_re_string = '^.*(?P<rc>\.[a-z]+rc)(\.(?P<tag>({hosts})))?'
    #mental note Python is pretty rad
    target = re.compile(target_re_string.format(hosts='|'.join(hosts.values())))
    hometarget = re.compile('(?P<rc>^\.[a-z]+rc)$')
    
    a = subprocess.check_output([ls, rc_repo_path ])
    contents= a.strip().split()
    rc_repo = {}
    for each in contents:
        found  = target.match(each)
        if found:
            # add the first .rc files of a type that is found to the dict
            #make sure you add one if there is nothing there 
            rc_repo[found.group('rc')] = os.path.join(rc_repo_path,
            found.group(0))


    a = subprocess.check_output([ls,'-a',home])
    contents = a.strip().split()

    for each in contents:
        found = hometarget.match(each)
        if found:
            if found.group('rc') in rc_repo.keys():
                unlock_rc(found.group('rc'))
                workon =os.path.join(home,found.group(0))
                bakup(workon)
                update_report(workon,rc_repo[found.group('rc')])
                delbakup(workon)
                lock_rc(found.group('rc'))


if __name__ == '__main__':
    main(sys.argv[2:])






