prefectures = %w(秋田 埼玉 岩手 山梨 栃木 青森 沖縄 群馬 新潟 神奈川 静岡)
0.upto(9) do |idx|
    Salon.create(
        owner_id: idx + 1,                         #外部キー
        name: "サロンNS#{prefectures[idx]}店",      #店名
        prefecture: "#{prefectures[idx]}県",       #都道府県
        adress: "#{idx}丁目#{idx}番地",             #住所
    )
end
