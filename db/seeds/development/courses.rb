cnames = ["カット", "カラー", "パーマ","髪質改善"]
money = [2900, 5400, 6800, 12600]
time = [2, 4, 5, 3]

0.upto(3) do |idx|
    Course.create(
        name: "#{cnames[idx]}",     #コース名
        price: money[idx],         #値段
        required_time: time[idx]             #所要時間
    )
end
