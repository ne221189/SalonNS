10.times do |idx|
    1.upto(7) do |day|
        start = DateTime.new(2024,1,day,9,0,0)
        24.times do |time|
            Shift.create!(
                stylist_id: idx + 1,
                date_time: start.since(30.minutes*time)
            )
        end
    end
end