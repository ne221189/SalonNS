fnames = ["小林", "加藤", "吉田","山田"]
gnames = ["タロー", "ジロー", "ハナコ"]

0.upto(9) do |idx|
    Stylist.create(
        salon_id: idx + 1,                                  #外部キー
        name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",      #名前
    )
end
