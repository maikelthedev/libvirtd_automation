# Libvirtd Automation

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