#!/bin/bash

DB=$KEEPASS_DB
TOKENS_FILE=$HOME/.local/tokens.sh

if [ ! -f "$DB" ]; then
    echo "Error: Database file '$DB' not found."
    exit 1
fi

read -rs -p "Enter KeePass Master Password: " KEEPASS_XC_PASS
echo "" 

if [ -f "$TOKENS_FILE" ]; then
    rm "$TOKENS_FILE"
fi
touch $TOKENS_FILE

SEARCH_RESULTS=$(echo $KEEPASS_XC_PASS | keepassxc-cli search -q "$DB" "+attr:API_KEY")

echo "$SEARCH_RESULTS" | while read -r entry_path; do
    NAME=$(echo $KEEPASS_XC_PASS | keepassxc-cli show -q  -s -a "API_KEY_NAME" "$DB" "$entry_path")
    KEY=$(echo $KEEPASS_XC_PASS | keepassxc-cli show -q  -s -a "API_KEY" "$DB" "$entry_path")

    # Sanitize NAME for shell compatibility (replace spaces/special chars with _)
    SAFE_NAME=$(echo "$NAME" | sed 's/[^a-zA-Z0-9_]/_/g')

    if [ -n "$SAFE_NAME" ] && [ -n "$KEY" ]; then
        echo "export $SAFE_NAME=\"$KEY\"" >> $TOKENS_FILE
    fi
done

mkdir -p $HOME/.config/rclone
echo $KEEPASS_XC_PASS | keepassxc-cli attachment-export -q "$KEEPASS_DB" "dev" "rclone.conf" $HOME/.config/rclone/rclone.conf

mkdir -p $HOME/.config/hcloud
echo $KEEPASS_XC_PASS | keepassxc-cli attachment-export -q "$KEEPASS_DB" "dev" "hcloud_cli.toml" $HOME/.config/hcloud/cli.toml

echo $KEEPASS_XC_PASS | keepassxc-cli attachment-export -q "$KEEPASS_DB" "dev" "wg.tgz" $HOME/wg.tgz
