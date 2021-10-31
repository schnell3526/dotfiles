###################
## ABCI
###################
if [[ ${HOSTNAME} =~ abci ]]; then
    # local設定用path
    LOCAL_PATH=${HOME}/.local
    # ncurses
    NCURSES_INC=${LOCAL_PATH}/include/ncurses
    export CPATH=$NCURSES_INC:$CPATH
    export LD_LIBRARY_PATH=${LOCAL_PATH}/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=${LOCAL_PATH}/lib/pkgconfig:$PKG_CONFIG_PATH
    # .localにパスを通す
    export PATH=${LOCAL_PATH}/bin:$PATH
fi
