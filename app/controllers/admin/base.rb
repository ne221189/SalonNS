class Admin::Base < ApplicationController
    # ログインを要求
    before_action :admin_login_required

    # current_userで判定できないので保留
    private def admin_login_required
        # raise Forbidden unless current_user&.administrator? # current_memberがnilならnilを返す
    end
end