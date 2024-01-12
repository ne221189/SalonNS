class Salon < ApplicationRecord
    # 一人のオーナーを持つ
    has_one :owner
    # 多数のスタイリストを持つ
    has_many :stylists
    # 多数のお気に入り登録を持つ
    has_many :votes

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
