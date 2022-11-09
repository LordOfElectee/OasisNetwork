#!/bin/bash
sudo apt update -y
sudo apt install bubblewrap gcc g++ gcc-multilib libclang-dev protobuf-compiler make cmake libssl-dev libseccomp-dev pkg-config mc ccze ncdu curl git -y
wget -O go1.18.3.linux-amd64.tar.gz https://golang.org/dl/go1.18.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz && rm go1.18.3.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && source $HOME/.bash_profile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install nightly
cargo +nightly install --git https://github.com/fortanix/rust-sgx --rev 998c34d158a69dd1af33f22587e8ae1c26ca6a27 fortanix-sgx-tools
cargo +nightly install --git https://github.com/fortanix/rust-sgx --rev 998c34d158a69dd1af33f22587e8ae1c26ca6a27 sgxs-tools
cd $HOME
git clone https://github.com/oasisprotocol/oasis-core.git
cd ./oasis-core
rustup show
echo 'export OASIS_UNSAFE_SKIP_AVR_VERIFY="1"' >> $HOME/.bash_profile
echo 'export OASIS_UNSAFE_SKIP_KM_POLICY="1"' >> $HOME/.bash_profile
echo 'export OASIS_UNSAFE_ALLOW_DEBUG_ENCLAVES="1"' >> $HOME/.bash_profile
echo 'export OASIS_BADGER_NO_JEMALLOC="1"' >> $HOME/.bash_profile
source $HOME/.bash_profile
make
mv ./go/oasis-node/oasis-node /usr/local/bin/
oasis-node -v
