class Course < ApplicationRecord
    # 多数の予約を持つ
    has_many :reservations
end
