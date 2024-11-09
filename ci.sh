#!/bin/bash
lb_ver=20230502
lb_deb="live-build_${lb_ver}_all.deb"
release_name="lory"
export DEBIAN_FRONTEND=noninteractive

set -e
if [[ "$1" == "--setup" ]]; then
    sudo DEBIAN_FRONTEND=noninteractive apt update
    sudo DEBIAN_FRONTEND=noninteractive apt install -y git live-build simple-cdd cdebootstrap
    [[ -f ${lb_deb} ]] || wget https://deb.parrot.sh/parrot/pool/main/l/live-build/${lb_deb}
    sudo DEBIAN_FRONTEND=noninteractive apt install -y ./${lb_deb}
fi

sudo cp -f parrot /usr/share/debootstrap/scripts/${release_name}
sudo cp -f parrot-archive-keyring.gpg /usr/share/keyrings/parrot-archive-keyring.gpg
sudo ln -sf /usr/share/live/build/data/debian-cd/sid /usr/share/live/build/data/debian-cd/${release_name}
set +e

./build.sh \
    --distribution ${release_name} \
    --version 6.2 \
    --variant xfce \
    --verbose
