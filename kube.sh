#!/bin/bash
# install serverless products in the following directory

get_machine_type() {
    local machine_type=$(uname -m)
    case "$machine_type" in
        x86_64)
            echo "amd64"
            ;;
        aarch64)
            echo "arm64"
            ;;
        *)
            echo "Unknown architecture"
            ;;
    esac
}

TMPDIR=/tmp/kube
mkdir -p $TMPDIR
BINDIR=$HOME/.local/bin
mkdir -p $BINDIR
mkdir -p $HOME/.kube

ln -sf $HOME/keys/kube/config $HOME/.kube/config

MTYPE=$(get_machine_type)
echo $MTYPE

# kubectl
curl -sSL https://dl.k8s.io/release/v1.30.9/bin/linux/$MTYPE/kubectl -o $BINDIR/kubectl
chmod +x $BINDIR/kubectl

# flux
FILENAME=v2.3.0/flux_2.3.0_linux_$MTYPE.tar.gz
curl -sSL https://github.com/fluxcd/flux2/releases/download/$FILENAME -o $TMPDIR/flux.tgz
tar -xzf $TMPDIR/flux.tgz -C $BINDIR

# hcloud
curl -sSL https://github.com/hetznercloud/cli/releases/download/v1.50.0/hcloud-linux-amd64.tar.gz -o $TMPDIR/flux.tgz
tar -xzf $TMPDIR/flux.tgz -C $BINDIR hcloud
