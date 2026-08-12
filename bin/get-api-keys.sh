#!/bin/bash

TOKENS_FILE=$HOME/.local/tokens.sh

if [ ! -f "$KEEPASS_DB" ]; then
    echo "Error: Database file '$KEEPASS_DB' not found."
    exit 1
fi

read -rs -p "Enter KeePass Master Password: " KEEPASS_XC_PASS
echo "" 

if [ -f "$TOKENS_FILE" ]; then
    rm "$TOKENS_FILE"
fi
touch $TOKENS_FILE

SEARCH_RESULTS=$(echo $KEEPASS_XC_PASS | keepassxc-cli search -q "$KEEPASS_DB" "+attr:API_KEY")

echo "$SEARCH_RESULTS" | while read -r entry_path; do
	echo $entry_path
    NAME=$(echo $KEEPASS_XC_PASS | keepassxc-cli show -q  -s -a "API_KEY_NAME" "$KEEPASS_DB" "$entry_path")
    KEY=$(echo $KEEPASS_XC_PASS | keepassxc-cli show -q  -s -a "API_KEY" "$KEEPASS_DB" "$entry_path")

    # Sanitize NAME for shell compatibility (replace spaces/special chars with _)
    SAFE_NAME=$(echo "$NAME" | sed 's/[^a-zA-Z0-9_]/_/g')

    if [ -n "$SAFE_NAME" ] && [ -n "$KEY" ]; then
        echo "export $SAFE_NAME=\"$KEY\"" >> $TOKENS_FILE
    fi
done


