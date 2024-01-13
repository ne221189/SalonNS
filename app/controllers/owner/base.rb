class Owner::Base < ApplicationController
    # ログインを要求
    before_action :own_login_required

    # current_userで判定できないので保留
    private def own_login_required
        # raise Forbidden unless current_member&.administrator? # current_memberがnilならnilを返す
    end
end