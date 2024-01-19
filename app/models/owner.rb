class Owner < ApplicationRecord
    has_secure_password

    # サロンに属する
    belongs_to :salon, optional: true
end
