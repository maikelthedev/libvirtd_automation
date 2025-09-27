# Libvirtd Automation

## Some assumptions
1. You have Fish shell
2. You use Nixos
3. Your system has all dependencies required for these fish functions
4. You have something along these lines on your `~/.ssh/config` file

```ini
Host *
  IdentityFile ~/.ssh/somekey.pub
```
Notice in my case it points to a public key as my private ones are in Bitwarden and I use Bitwarden SSH Agent which changes any reference to a public key for its private one. If yours point to  a public one (e.g.: same without .pub) then replace in `fish_functions/clone_user_data` the next lines

```fish
# Change this line
  set PUBKEY (cat $PUBKEYFILE)
  
# For this line
  set PUBKEY (cat $PUBKEYFILE.pub)
```

## How to prepare

```fish
# Clone it in a ~/vms folder
git clone git@github.com:maikelthedev/libvirtd_automation.git ~/vms

# Append to ~/.config/fish/config.fish
set -g fish_function_path $fish_function_path ~/vms/fish_functions
``` 

## How to use

On a fresh Fish session so it loads the functions

```fish
# Create the in_use folder, just once. 
mkdir $HOME/vms/in_use

# Clone user-data
clone_user_data NAME_OF_VM

# Edit the file
vi $HOME/vms/in_use/NAME_OF_VM/NAME_OF_VM-user-data.yaml

# Create the VM
create_the_vm NAME_OF_VM
``` 

That's it