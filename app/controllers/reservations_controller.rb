class ReservationsController < ApplicationController
    before_action :login_required
    # 予約情報
    def index
        # ログイン中のユーザーの予約リスト
        @reservations = Reservation.where(customer_id: current_user.id)
    end

    # 予約フォーム
    def new
        # 予約インスタンス
        @reservation = Reservation.new(params[:reservation])

        # スタイリスト
        @stylist = Stylist.find_by(id: params[:stylist_id])

        # スタイリストが可用な時間
        @shifts = Shift.where(stylist_id: params[:stylist_id]).order(date_time: :asc)

        #　コース番号
        @course = Course.find_by(id: params[:course_id])

        # 所要時間
        @required_time = @course.required_time


        # シフトが枠単位で空いているかどうか判定する配列を作成
        # 各要素は空いているかどうか(is_free)とそのシフト自体のインスタンス(shifts)のハッシュ
        @shift_range = @shifts.first.date_time.to_date..@shifts.last.date_time.to_date
        # 列数(integer)
        size = @shifts.last.date_time.to_date - @shifts.first.date_time.to_date + 1
        # 二次元配列の初期化
        @shift_is_free = Array.new(48) { Array.new(size) { { is_free: false, shift: Shift.new } } }
        # 配列の要素をセット
        48.times do |half_hour|
            time = Time.new(2024, 1, 1, half_hour / 2, (half_hour % 2) * 30)
            puts time.strftime("%H:%M")
            # 日付ごとのセル
            @shift_range.each_with_index do |date, day|
                date_time = Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
                shift = @shifts.find_by(date_time: date_time)
                # 枠が埋まっているかどうか
                if shift && shift.reservation_id.nil?
                    @shift_is_free[half_hour][day][:is_free] = true
                    @shift_is_free[half_hour][day][:shift] = shift
                end
            end
        end
    end

    # 予約登録
    def create
        @reservation = Reservation.new(params[:reservation])

        # shiftテーブルのインスタンスに関連付け(動かない)
        initial_shift = Shift.find(params[:shift_id])
        shifts = Shift.where(stylist_id: initial_shift.stylist_id).order(:date_time)
                      .offset(initial_shift.id - 1).limit(@reservation.reserved_time)
        @reservation.shifts << shifts

        if @reservation.save
            redirect_to :root, notice: "予約を確定しました。"
        else
            # エラー未実装
            flash[:alert] = @reservation.errors.full_messages.join(', ')
            render "new"
        end
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to :reservations, notice: "予約を削除しました。"
    end
end