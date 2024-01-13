class Admin::AccountsController < Admin::Base
    # ログインを要求
    before_action :admin_login_required, except: [:new, :create]
    def show
        # ログイン中のユーザー
        @user = current_administrator
    end
end
