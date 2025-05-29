
SPECIFIC_TERMUX="openssh gh neovim python-pip fd binutils termux-api kubectl "
PACKAGES="git gnupg tmux bash-completion ripgrep build-essential jq htop zip unzip fzf bat curl "
APP_ALT="hcloud rclone"
pkg update -y
pkg upgrade -y
pkg install -y $SPECIFIC_TERMUX $PACKAGES $APP_ALT $FOR_LANGCHAIN

mkdir -p $HOME/bin
ln -sf /data/data/com.termux/files/usr/bin/nvim $HOME/bin/termux-file-editor
cp $HOME/projects/dev/dotfiles/termux.properties $HOME/.termux

TMPDIR=./tmp/kube
mkdir -p $TMPDIR
BINDIR=$HOME/.local/bin
mkdir -p $BINDIR

# flux
FILENAME=v2.5.1/flux_2.5.1_linux_arm64.tar.gz
curl -sSL https://github.com/fluxcd/flux2/releases/download/$FILENAME -o $TMPDIR/flux.tgz
tar -xzf $TMPDIR/flux.tgz -C $BINDIR
