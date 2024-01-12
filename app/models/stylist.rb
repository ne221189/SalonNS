class Stylist < ApplicationRecord
    # 多数のシフトを持つ
    has_many :shifts
end
