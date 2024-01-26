class Owner::ShiftsController < Owner::Base
    before_action :owner_login_required
    private def make_table(shifts, shift_range, shift_is_free)
        # 配列の要素をセット
        48.times do |half_hour|
            # 時間を動かすための変数
            time = Time.new(2024, 1, 1, half_hour / 2, (half_hour % 2) * 30)
            # 日付ごとのセル
            shift_range.each_with_index do |date, day|
                date_time = Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
                shift = shifts.find_by(date_time: date_time)
                # シフトのセット
                if shift.nil?
                    shift_is_free[half_hour][day][:absent] = true
                    shift_is_free[half_hour][day][:shift] = Shift.new(date_time: date_time)
                else
                    shift_is_free[half_hour][day][:shift] = shift
                end
            end
        end
    end

    def index
        @stylist = Stylist.find_by(id: params[:stylist_id])
        @shifts = Shift.where(stylist_id: params[:stylist_id])
        # 日数(integer)
        size = 10
        @shift_range = Time.now.since(1.day).to_date..Time.now.since((size).days)
        # 二次元配列の初期化
        @shift_existence = Array.new(48) { Array.new(size) { { absent: false, shift: Shift.new } } }

        make_table(@shifts, @shift_range, @shift_existence)
    end

    def new
        @stylist = Stylist.find_by(id: params[:stylist_id])
        @shifts = Shift.where(stylist_id: params[:stylist_id]).order(date_time: :asc)
        # 日数(integer)
        size = 10
        @shift_range = Time.now.since(1.day).to_date..Time.now.since((size).days)
        # 二次元配列の初期化
        @shift_existence = Array.new(48) { Array.new(size) { { absent: false, date_time: Time.new } } }

        make_table(@shifts, @shift_range, @shift_existence)
    end

    def create
        stylist = Stylist.find_by(id: params[:stylist_id])
        date_times = params[:date_times]
        if date_times.nil?
            redirect_to new_owner_stylist_shift_path(params[:stylist_id]), notice: "追加する日時を選択してください。"
            return
        end
        date_times&.each do |date_time|
            Shift.new(stylist_id: params[:stylist_id], reservation_id: nil, date_time: date_time).save
        end
        redirect_to [:new, :owner, stylist, :shift], notice: "シフトを追加しました。"
    end

    def destroy
        stylist = Stylist.find_by(id: params[:stylist_id])
        shift_ids = params[:shift_ids]
        if shift_ids.nil?
            redirect_to [:owner, stylist, :shifts], notice: "削除するシフトを選択してください。"
            return
        end
        # 予約が入っているかのチェック
        shift_ids&.each do |shift_id|
            shift = Shift.find_by(id: shift_id)
            unless shift&.reservation_id.nil?
                redirect_to [:owner, stylist, :shifts], notice: "予約されているシフトが含まれています。"
                return
            end
        end
        # 削除
        shift_ids&.each do |shift_id|
            shift = Shift.find_by(id: shift_id)
            shift&.destroy
        end
        redirect_to [:owner, stylist, :shifts], notice: "シフトを削除しました。"
    end
end
