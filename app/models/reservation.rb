class Reservation < ApplicationRecord
    # 多数のシフトを持つ
    has_many :shifts
    # 利用者に属する
    belongs_to :customer

    # 空を禁止
    validates :reserved_date, :reserved_date, :sum_price, :course_id, presence: true
end