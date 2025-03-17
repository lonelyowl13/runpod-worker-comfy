#!/bin/bash

export PIP_ROOT_USER_ACTION=ignore

# The list of nodes
NODES=(
  "https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git ComfyUI_UltimateSDUpscale"
  "https://github.com/ltdrdata/ComfyUI-Impact-Pack.git ComfyUI-Impact-Pack"
)

# Node install function
clone_and_install() {

  cd /comfyui/custom_nodes

  for repo in "${NODES[@]}"; do
    url=$(echo "$repo" | cut -d' ' -f1)
    name=$(echo "$repo" | cut -d' ' -f2)

    if [ ! -d "$name" ] || [ -z "$(ls -A "$name")" ]; then
      echo "Cloning $name..."
      git clone --recurse-submodules "$url" "$name"

      if [ -f "$name/requirements.txt" ]; then
        echo "Installing requirements for $name..."
        cd "$name"
        pip install -r requirements.txt
        cd ..
      fi
    else
      echo "Skipping $name, folder is not empty or already exists."
    fi
  done
}

clone_and_install