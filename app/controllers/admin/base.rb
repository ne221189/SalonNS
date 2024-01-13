class Admin::Base < ApplicationController

    # current_userで判定できないので保留
    private def admin_login_required
        raise Forbidden unless current_administrator # current_administratorがnilならnilを返す
    end
end