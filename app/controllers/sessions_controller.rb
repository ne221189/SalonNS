class SessionsController < ApplicationController
    def create
        # 送信された名前に合致する利用者を取り出し、セット (&.はnilがセットされた時のエラー防止)
        user = Customer.find_by(name: params[:name])
        # パスワードが一致すればidをセッションに保存
        if user&.authenticate(params[:password])
            session[:customer_id] = user.id
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :root
    end

    # ログアウト
    def destroy
        session.delete(:customer_id)
        redirect_to :root
    end
end