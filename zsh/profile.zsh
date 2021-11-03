if [[ ${HOSTNAME} =~ abci ]]; then
# ABCI用の設定
    # local設定用path
    LOCAL_PATH=${HOME}/.local
    # ncurses
    NCURSES_INC=${LOCAL_PATH}/include/ncurses
    export CPATH=$NCURSES_INC:$CPATH
    export LD_LIBRARY_PATH=${LOCAL_PATH}/lib:$LD_LIBRARY_PATH
    export PKG_CONFIG_PATH=${LOCAL_PATH}/lib/pkgconfig:$PKG_CONFIG_PATH
    # .localにパスを通す
    export PATH=${LOCAL_PATH}/bin:$PATH
    # 共有フォルダにパスを通す
    export PATH=${DIR_GROUP}/share/usr/bin:$PATH

    # よく使うモジュールをロード
    module load gcc/9.3.0
    module load python/3.8/3.8.7
    module load julia/1.5
    module load singularitypro/3.7
elif [[ $(uname) = "Darwin" ]]; then # OSX
    # 環境変数
    export LANG=ja_JP.UTF-8
    export KCODE=u           # KCODEにUTF-8を設定
    export PATH="/usr/local/bin:$PATH"
    # go
    export PATH="/usr/local/opt/go@1.16/bin:$PATH"
fi
