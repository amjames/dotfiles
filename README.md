# Dotfiles 
# By Andrew M. James 
---
This is a collection of all of my <whatever>rc files. Or really 
any file that has configuration/macros/shortcuts for some program I use. Ideally 
I can clone the repo on any computer and I will have most of the 
environment set up the way I like it, and if I am playing around with 
something and I break it I have long line of working predecessors to fall back 
on!

##cshrc
-using the tcshell on my mac. 

##basrc
-bashrc file for any computers I may come across

##vimrc
-vim settings/binding/functions that I find handy, as well as plugins 

##mutt
-various setup/config files for the mutt mail client.

##oflineimap
-used in conjunction with mutt to get new email from gmail's IMAP servers 

##mklink
-Script that will make a symbolic link(s) to set up the target environment
-f. and d. tags on files and directories just make life a little easier for the script and now all the .<whatever> files arent hidden 
###Usage
    mklink vim 
-makes a symbolic link in ~/ to f.vimrc and calls it ~/.vimrc 
-makes a symbolic link in ~/.vim to d.after and calls it ~/.vim/after







