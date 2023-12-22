names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]

0.upto(9) do |idx|
    Customer.create(
        name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",      # 名前
        email: "#{names[idx]}@example.com",                 # メールアドレス
        phone: "090-12#{idx}-98#{idx}",                     # 電話番号
        sex: [1, 1, 2][idx % 3],                            # 性別
        birthday: "1981-12-01"                              # 生年月日
    )
end
