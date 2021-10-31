# プロンプトの設定

###################
## ABCI
###################
if [[ ${HOSTNAME} =~ abci ]]; then
    # 左プロンプトの表示設定
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir vcs newline virtualenv)
    # 右プロンプトの表示設定
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
    # 新しい行を挿入
    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    POWERLEVEL9K_PROMPT_ADD_NEWLINE_COUNT=1
    # host表示設定
    POWERLEVEL9K_HOST_TEMPLATE="%2m"
    # venvの表示設定
    POWERLEVEL9K_VIRTUALENV_FOREGROUND='red'
    POWERLEVEL9K_VIRTUALENV_BACKGROUND='grey35'
    # 設定を反映
    source /home/acc12730ud/powerlevel9k/powerlevel9k.zsh-theme
fi