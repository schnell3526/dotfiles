# プロンプトの設定

if [[ ${HOSTNAME} =~ abci ]]; then # ABCI
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
elif [[ $(uname) = "Darwin" ]]; then # OSX
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    ## プロンプトカスタマイズ
    zinit ice depth=1; zinit light romkatv/powerlevel10k
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi