function clone_user_data
    if test (count $argv) -ne 1
        echo "Usage: clone_user_data <vmname>"
        return 1
    end

    set NEWVM $argv[1]
    set BASE "$HOME/vms/user-data.yaml"
    set VM_DIR "$HOME/vms/in_use/$NEWVM"
    mkdir -p "$VM_DIR"
    echo "Created directory $VM_DIR"
    set OUT "$VM_DIR/$NEWVM-user-data.yaml"

    if not test -f $BASE
        echo "Error: base file $BASE does not exist"
        return 1
    end

    if test -z "$ZT_TOKEN"
        echo "Error: ZT_TOKEN environment variable not set"
        return 1
    end

    if test -z "$ZT_NWID"
        echo "Error: ZT_NWID environment variable not set"
        return 1
    end

    if test -z "$DEFAULT_VM_PASSWORD"
        echo "Error: DEFAULT_VM_PASSWORD environment variable not set"
        return 1
    end

    # Generate hashed password
    set PASSWD (mkpasswd -m sha-512 $DEFAULT_VM_PASSWORD)

    # Extract default identity file from ssh config (already a .pub in your setup)
    set PUBKEYFILE (grep -m1 -i 'IdentityFile' ~/.ssh/config | awk '{print $2}' | sed "s|~|$HOME|")
    if test -z "$PUBKEYFILE"
        echo "Error: could not find IdentityFile in ~/.ssh/config"
        return 1
    end

    if not test -f $PUBKEYFILE
        echo "Error: public key $PUBKEYFILE not found"
        return 1
    end

    # If not using Bitwrden this should end in .pub
    set PUBKEY (cat $PUBKEYFILE)

    sed \
        -e "s|{{VM_NAME}}|$NEWVM|g" \
        -e "s|{{NWID}}|$ZT_NWID|g" \
        -e "s|{{ZT_TOKEN}}|$ZT_TOKEN|g" \
        -e "s|{{PASSWD}}|$PASSWD|g" \
        -e "s|{{SSH_PUBKEY}}|$PUBKEY|" \
        $BASE >$OUT

    if test $status -ne 0
        echo "Error: failed to generate $OUT"
        return 1
    end

    echo "Created config: $OUT"
end
