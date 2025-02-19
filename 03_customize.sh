#!/bin/bash
array=(
  'https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/'
  'https://extensions.gnome.org/extension/517/caffeine/'
  'https://extensions.gnome.org/extension/3193/blur-my-shell/'
  'https://extensions.gnome.org/extension/3843/just-perfection/'
  'https://extensions.gnome.org/extension/5237/rounded-window-corners/'
  'https://extensions.gnome.org/extension/2890/tray-icons-reloaded/'
  'https://extensions.gnome.org/extension/5940/quick-settings-audio-panel/'
  'https://extensions.gnome.org/extension/5446/quick-settings-tweaker/'
)

# Loop through each URL
for i in "${array[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    gnome-extensions install --force ${EXTENSION_ID}.zip
    if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
        busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
    fi
    gnome-extensions enable ${EXTENSION_ID}
    rm ${EXTENSION_ID}.zip
done
