#!/bin/bash

cd $LOCAL_PATH/src
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.33.1.tar.gz --no-check-certificate
tar xvzf git-2.33.1.tar.gz
cd git-2.33.1
./configure --prefix=$LOCAL_PATH
make -j $(nproc)
make install