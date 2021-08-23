class Public::HomesController < ApplicationController


# トップ画面はヘッダー・フッターをなくすためレイアウトを指定
    def top
    render layout: 'top'
    end

end
