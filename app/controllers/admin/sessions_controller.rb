class Admin::SessionsController < Admin::Base
    def create
        # 送信された名前に合致する利用者を取り出し、セット (&.はnilがセットされた時のエラー防止)
        administrator = Administrator.find_by(name: params[:name])

        # パスワードが一致すればidをセッションに保存
        if administrator&.authenticate(params[:password])
            session[:administrator_id] = administrator.id
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :admin_root
    end

    # 必要かどうか検討
    def destroy
        # 利用者を削除
        session.delete(:administrator_id)
        redirect_to :admin_root
    end
end