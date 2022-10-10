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
    module load gcc/9.3.0 python/3.8
elif [[ $(uname) = "Darwin" ]]; then # OSX
    # 環境変数
    export LANG=ja_JP.UTF-8
    export KCODE=u           # KCODEにUTF-8を設定
    export PATH="/usr/local/bin:$PATH"
    export PATH="/Users/schnell/nlp/bin:$PATH"
    # go
    export PATH="/usr/local/opt/go@1.16/bin:$PATH"
    export PATH=$HOME/.nodebrew/current/bin:$PATH
elif [[ $(uname) = "Linux" ]]; then # 研GPU
    export PATH="/home/share/bin:$PATH"
    export LANG=ja_JP.UTF-8
    export PATH="$HOME/usr/bin:$PATH"
    source /apps/Modules/init/zsh
    module load gcc/11.2 cuda/11.6/11.6.2 cudnn/8.2/8.2.4
fi
