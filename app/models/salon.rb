class Salon < ApplicationRecord
    # 一人のオーナーを持つ
    has_one :owner, dependent: :nullify
    # 多数のスタイリストを持つ
    has_many :stylists
    # 多数のお気に入り登録を持つ
    has_many :votes, dependent: :destroy
    has_many :voters, through: :votes, source: :customer

    # 美容院名バリデーション 最大10文字、空はNG
    validates :name, presence: true,
              length: { maximum: 10 }
    # 都道府県バリデーション 空はNG
    validates :prefecture, presence: true
    # 住所バリデーション 空はNG
    validates :adress, presence: true
    class << self
        # 美容院検索用クラスメソッド
        def search(pref, liked, user)
            rel = order("id")
            if liked
                rel = user.voted_salons
            end
            if pref.present?
                rel = rel.where(prefecture: pref)
            end
            rel
        end
    end
end
