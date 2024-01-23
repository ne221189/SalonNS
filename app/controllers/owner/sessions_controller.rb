class Owner::SessionsController < Owner::Base
    def create
        # 送信された名前に合致する利用者を取り出し、セット (&.はnilがセットされた時のエラー防止)
        owner = Owner.find_by(name: params[:name])
        if current_customer or current_administrator
            flash.alert = "同時に複数アカウントでのログインはできません"
            redirect_to :owner_root
            return
        end
        # パスワードが一致すればidをセッションに保存
        if owner&.authenticate(params[:password])
            session[:owner_id] = owner.id
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_to :owner_root
    end

    # ログアウト
    def destroy
        session.delete(:owner_id)
        redirect_to :owner_root
    end
end