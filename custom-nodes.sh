#!/bin/bash

set -eux

CUSTOM_NODES_CONF="${PWD}/custom-nodes.conf"

if [[ ! -f "$CUSTOM_NODES_CONF" ]]; then
    echo "Error: Configuration file '$CUSTOM_NODES_CONF' not found."
    exit 1
fi

while IFS="|" read -r url recursive || [[ -n "$url" ]]; do
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    url=$(echo "$url" | xargs)
    repo_name=$(basename "$url" .git)
    recursive=$(echo "$recursive" | xargs)

    target_path="${PWD}/$repo_name"

    GIT_CMD="git clone --depth 1"
    [ "$recursive" == "y" ] && GIT_CMD="$GIT_CMD --recursive"

    $GIT_CMD "$url" "$target_path"
done < "$CUSTOM_NODES_CONF"

# pip install --no-cache-dir --upgrade-strategy only-if-needed \
#     -r "${COMFYUI}/requirements.txt" \
#     einops==0.8.0 \
#     sageattention==1.0.6

# python "${COMFYUI}/custom_nodes/x-flux-comfyui/setup.py"
# python "${COMFYUI}/custom_nodes/ComfyUI-Impact-Pack/install.py"
# python "${COMFYUI}/custom_nodes/ComfyUI-Frame-Interpolation/install.py"
