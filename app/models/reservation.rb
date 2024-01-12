class Reservation < ApplicationRecord
    # 多数のシフトを持つ
    has_many :shifts
    # 利用者に属する
    belongs_to :customer
end