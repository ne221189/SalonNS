class Vote < ApplicationRecord
    # 利用者に属する
    belongs_to :customer
    # 美容院に属する
    belongs_to :salon

    validate do
        unless customer && customer.votable_for?(salon)
            errors.add(:base, :invalid)
        end
    end
end
