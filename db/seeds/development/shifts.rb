10.times do |idx|
    5.times do |day|
        start = Time.new(2024,1,27,9,0,0).since(day.days)
        24.times do |time|
            Shift.create!(
                stylist_id: idx + 1,
                date_time: start.since(30.minutes*time)
            )
        end
    end
end