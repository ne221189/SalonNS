names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom Donald Hathaway Mira)
fnames = ["伊藤", "渡辺", "山本", "中村", "斉藤", "田淵"]
gnames = ["太郎", "次郎", "花子", "昭恵"]

0.upto(12) do |idx|
    Owner.create!(
        salon_id: (idx > 9 ? nil: idx+1),                   #外部キー
        name: "#{fnames[idx % 6]} #{gnames[idx % 4]}",      #名前
        email: "#{names[idx]}.owner@example.com",           #メールアドレス
        phone: "090-98#{idx}-12#{idx}",                     #電話番号
        sex: [1, 1, 2, 2][idx % 4],                         #性別
        birthday: "1981-12-01",                             #生年月日
        password: "salonNS2023",                            # パスワード
        password_confirmation: "salonNS2023"                # 確認用パスワード
    )
end
