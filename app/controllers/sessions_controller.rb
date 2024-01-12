class SessionsController < ApplicationController
    def create
        # 送信された名前に合致する利用者を取り出し、セット (&.はnilがセットされた時のエラー防止)
        user = Customer.find_by(name: params[:name])
        # if user.nil?
        #     user = Administrator.find_by(name: params[:name])
        # end
        # if user.nil?
        #     user = Owner.find_by(name: params[:name])
        # end

        # パスワードが一致すればidをセッションに保存
        if user&.authenticate(params[:password])
            session[:customer_id] = user.id
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :root
    end

    # 必要かどうか検討
    def destroy
        # 利用者を削除
        session.delete(:customer_id)
        redirect_to :root
    end
end