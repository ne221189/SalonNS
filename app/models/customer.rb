class Customer < ApplicationRecord
    has_secure_password

    # お気に入りできるか調べるメソッド
    def votable_for?(salon)
        salon && !votes.exists?(salon_id: salon.id)
    end

    # 多数の予約を持つ
    has_many :reservations
    # 多数のお気に入りを持つ
    has_many :votes, dependent: :destroy
    has_many :voted_salons, through: :votes, source: :salon

    # current_password属性をMemberクラスに追加
    attr_accessor :current_password
    # 空文字でもnilでもない
    validates :password, presence: { if: :current_password }

    # ユーザー名バリデーション 最大10文字、空はNG
    validates :name, presence: true, length: { maximum: 10 }
    # 生年月日バリデーション 今日より前
    validates :birthday, comparison: { less_than: Time.current.to_date }
    # 数字・ハイフン・丸括弧のみから構成、8文字以上20文字以内、空白NG
    validates :phone, presence: true,
              format: { with: /\A[0-9\(\)-]*\z/, allow_blank: true },
              length: { minimum: 8, maximum: 20, allow_blank: true }
    # Eメールバリデーション
    validates :email, email: { allow_brank: true }
    # パスワードバリデーション 空白はNG、数字・ハイフン・丸括弧のみから構成、8文字以上20文字以内x
    validates :password, presence: { if: :current_password },
              format: { with: /\A[0-9A-Za-z!]*\z/, allow_blank: true,
                        message: "must consist of alphanumeric characters or '!'"},
              length: { minimum: 8, maximum: 20, allow_blank: true }
end
