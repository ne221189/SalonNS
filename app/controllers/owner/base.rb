class Owner::Base < ApplicationController
    private def owner_login_required
        raise Forbidden unless current_owner # current_ownerがnilならnilを返す
    end
end