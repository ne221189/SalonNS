class Vote < ApplicationRecord
    # 利用者に属する
    belongs_to :customer
    # 美容院に属する
    belongs_to :salon
end
