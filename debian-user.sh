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




BINDIR=$HOME/.local/bin
mkdir -p $BINDIR

TMPDIR=/tmp/install
mkdir -p $TMPDIR

ln -sf /usr/bin/batcat $HOME/.local/bin/bat
ln -sf /usr/bin/fdfind $HOME/.local/bin/fd

MTYPE=$(get_machine_type)


# --- get the right yq for debian (the standard one is strange) 
curl -L https://github.com/mikefarah/yq/releases/download/v4.45.4/yq_linux_$MTYPE -o $BINDIR/yq && chmod +x $BINDIR/yq

# gh cli
curl -L https://github.com/cli/cli/releases/download/v2.70.0/gh_2.70.0_linux_$MTYPE.tar.gz -o $TMPDIR/gh.tgz
tar -xf $TMPDIR/gh.tgz -C $BINDIR --strip-components=2 gh_2.70.0_linux_$MTYPE/bin/gh

# nvm/node/npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 20

# --------------- cloud native stufff
#

# kubectl
curl -sSL https://dl.k8s.io/release/v1.30.9/bin/linux/$MTYPE/kubectl -o $BINDIR/kubectl
chmod +x $BINDIR/kubectl

# flux
FILENAME=v2.5.1/flux_2.5.1_linux_$MTYPE.tar.gz
curl -sSL https://github.com/fluxcd/flux2/releases/download/$FILENAME -o $TMPDIR/flux.tgz
tar -xzf $TMPDIR/flux.tgz -C $BINDIR

# hcloud
curl -sSL https://github.com/hetznercloud/cli/releases/download/v1.50.0/hcloud-linux-$MTYPE.tar.gz -o $TMPDIR/hcloud.tgz
