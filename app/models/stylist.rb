class Stylist < ApplicationRecord
    # 多数のシフトを持つ
    has_many :shifts, dependent: :destroy

    belongs_to :salon

    # スタイリスト名バリデーション 最大10文字、空はNG
    validates :name, presence: true,
              length: { maximum: 10 }
end
