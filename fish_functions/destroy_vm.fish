function destroy_vm
    if test (count $argv) -lt 1
        echo "Usage: destroyvm <vm-name>"
        return 1
    end

    set vm $argv[1]

    echo "Destroying VM $vm..."
    virsh destroy $vm

    echo "Undefining VM $vm..."
    virsh undefine $vm

    set disk ~/vms/in_use/$vm/$vm.qcow2
    set seed ~/vms/in_use/$vm/$vm.iso   
    set userdata ~/vms/in_use/$vm/$vm-user-data.yaml

    if test -f $disk
        echo "Deleting disk $disk..."
        rm -f $disk
    else
        echo "Disk $disk not found, skipping."
    end
    
    if test -f $seed
        echo "Deleting seed $seed..."
        rm -f $seed
    else
        echo "Disk $seed not found, skipping."
    end

    if test -f $userdata
        echo "Deleting user-data $userdata..."
        rm -f $userdata
    else
        echo "Disk $userdata not found, skipping."
    end

    rm -rf $HOME/vms/in_use/$vm
  end
