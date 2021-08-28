class Public::HomesController < ApplicationController


# トップ画面はヘッダーをなくすためレイアウトを指定
    def top
    render layout: 'top'
    end

end
