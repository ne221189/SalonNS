class Customer < ApplicationRecord
    has_secure_password

    # 多数の予約を持つ
    has_many :reservations
    # 多数のお気に入りを持つ
    has_many :votes

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }
end
