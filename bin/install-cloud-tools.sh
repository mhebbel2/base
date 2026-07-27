#!/bin/bash
set -e

BINDIR=$HOME/.local/bin
mkdir -p $BINDIR

# Maps x86_64 -> amd64, aarch64 -> arm64
ARCH=$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')

# kubectl
curl -sSL https://dl.k8s.io/release/v1.33.4/bin/linux/$ARCH/kubectl -o $BINDIR/kubectl
chmod +x $BINDIR/kubectl

# flux
curl -sSL "https://github.com/fluxcd/flux2/releases/download/v2.7.5/flux_2.7.5_linux_$ARCH.tar.gz" | tar -xz -C "$BINDIR"

# hcloud
curl -sSL "https://github.com/hetznercloud/cli/releases/download/v1.50.0/hcloud-linux-$ARCH.tar.gz" | tar -xz -C "$BINDIR"

# completion & aliases (added to .bashrc only when these tools are installed)
touch $HOME/.bashrc
if ! grep -q "kubectl completion bash" $HOME/.bashrc; then
	cat <<'EOF' >> $HOME/.bashrc

if command -v kubectl &>/dev/null; then
	alias k='kubectl'
	source <(kubectl completion bash)
	complete -o default -F __start_kubectl k
	export KUBE_EDITOR=nvim
fi

if command -v flux &>/dev/null; then
	source <(flux completion bash)
fi

if command -v hcloud &>/dev/null; then
	source <(hcloud completion bash)
fi
EOF
fi
