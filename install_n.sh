#!/bin/bash


# インストール先パス
LOCAL_PATH=${HOME}/.local

# create working dir
mkdir ~/build
cd ~/build

#############################
### install ncurses
#############################
wget --no-check-certificate https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.2.tar.gz
tar xvfz ncurses-6.2.tar.gz
cd ncurses-6.2
./configure --prefix=${LOCAL_PATH}/ncurses/6_2 --with-shared --with-pkg-config-libdir=${LOCAL_PATH}/ncurses/6_2/lib/pkgconfig --enable-pc-files
make -j "$(nproc)"
make install

# ${LOCAL_PATH}/bin
cd ${HOME}/build
if [ -d ${LOCAL_PATH}/bin/ ]; then
    ls --color=never -p -1 ${LOCAL_PATH}/ncurses/6_2/bin/ | grep -v / | xargs -I{} ln -s ${LOCAL_PATH}/ncurses/6_2/bin/{} ${LOCAL_PATH}/bin/{}
else
    mkdir ${LOCAL_PATH}/bin/
    ls --color=never -p -1 ${LOCAL_PATH}/ncurses/6_2/bin/ | grep -v / | xargs -I{} ln -s ${LOCAL_PATH}/ncurses/6_2/bin/{} ${LOCAL_PATH}/bin/{}
fi

# ${LOCAL_PATH}/include
if [ -d ${LOCAL_PATH}/include/ ]; then
    ln -s ${LOCAL_PATH}/ncurses/6_2/include/ncurses ${LOCAL_PATH}/include/
else
    mkdir ${LOCAL_PATH}/include/
    ln -s ${LOCAL_PATH}/ncurses/6_2/include/ncurses ${LOCAL_PATH}/include/
fi

# ${LOCAL_PATH}/lib
if [ -d ${LOCAL_PATH}/lib/ ]; then
    ls --color=never -p -1 ${LOCAL_PATH}/ncurses/6_2/lib/ | grep -v / | xargs -I{} ln -s ${LOCAL_PATH}/ncurses/6_2/lib/{} ${LOCAL_PATH}/lib/{}
else
    mkdir ${LOCAL_PATH}/lib/
    ls --color=never -p -1 ${LOCAL_PATH}/ncurses/6_2/lib/ | grep -v / | xargs -I{} ln -s ${LOCAL_PATH}/ncurses/6_2/lib/{} ${LOCAL_PATH}/lib/{}
fi

#############################
### install p9k
#############################

cd ${HOME}
git clone https://github.com/Powerlevel9k/powerlevel9k.git