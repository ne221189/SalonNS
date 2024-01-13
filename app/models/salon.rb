class Salon < ApplicationRecord
    # 一人のオーナーを持つ
    has_one :owner
    # 多数のスタイリストを持つ
    has_many :stylists
    # 多数のお気に入り登録を持つ
    has_many :votes

    # 美容院名バリデーション 最大10文字、空はNG
    validates :name, presence: true,
              length: { maximum: 10 }
    # 都道府県バリデーション 空はNG
    validates :prefecture, presence: true
    # 住所バリデーション 空はNG
    validates :adress, presence: true
    class << self
        # 美容院検索用クラスメソッド(今は地域だけ)
        def search(query)
            rel = order("id")
            if query.present?
                rel = rel.where(prefecture: query)
            end
            rel
        end
    end
end
