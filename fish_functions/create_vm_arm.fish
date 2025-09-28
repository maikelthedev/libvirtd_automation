function create_vm_arm
    if test (count $argv) -lt 1
        echo "Usage: create_vm_arm <vm-name>"
        return 1
    end

    set vm $argv[1]

    set vm_dir $HOME/vms/in_use/$vm
    cd $vm_dir

    echo "Copying template to VM disk..."
    cp $HOME/vms/freebsd-arm.qcow2 $vm.qcow2

    echo "Creating seed ISO..."
    cloud-localds $vm.iso $vm-user-data.yaml

    echo "Resizing disk..."
    qemu-img resize $vm.qcow2 10G

    echo "Launching VM..."
    virt-install \
        --connect qemu:///system \
        --name $vm \
        --memory 4096 \
        --vcpus 4 \
        --disk path=$vm.qcow2,format=qcow2,bus=virtio \
        --disk path=$vm.iso,device=cdrom \
        --os-variant freebsd14.0 \
        --import \
        --network network=maikenet,model=virtio \
        --graphics spice \
        --arch aarch64 \
        --machine virt #\
        # --noautoconsole

    echo "VM $vm launched."
end
