class ReservationsController < ApplicationController
    before_action :login_required, except: [:index, :show]
    # 予約情報
    def index
        # ログイン中のユーザーの予約リスト
        @reservations = Reservation.where(customer_id: current_customer.id)

        # 終わったものとそうでないものの仕分け(予約先のシフトが欠損している場合も同じ扱い)
        @coming, @finished = sort_reservations(@reservations)
    end

    # 予約表の元となる二次元配列を作成
    private def make_table(shifts, shift_range, shift_is_free)
        # 配列の要素をセット
        48.times do |half_hour|
            # 時間を動かすための変数
            time = Time.new(2024, 1, 1, half_hour / 2, (half_hour % 2) * 30)
            # 日付ごとのセル
            shift_range.each_with_index do |date, day|
                date_time = Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
                shift = shifts.find_by(date_time: date_time)
                # 枠が埋まっているかどうか
                if shift && shift.reservation_id.nil?
                    shift_is_free[half_hour][day][:is_free] = true
                    shift_is_free[half_hour][day][:shift] = shift
                end
            end
        end
    end

    # 予約フォーム
    def new
        if params[:stylist_id].nil? or params[:course_id].nil?
            redirect_to "/salons/#{params[:salon_id]}", notice: "入力しなおしてください。"
            return
        end
        # 予約インスタンス
        @reservation = Reservation.new(params[:reservation])

        # スタイリスト
        @stylist = Stylist.find_by(id: params[:stylist_id])

        # スタイリストが持つシフト
        @shifts = Shift.where(stylist_id: params[:stylist_id]).order(date_time: :asc)

        #　コース番号
        @course = Course.find_by(id: params[:course_id])

        # 所要時間
        @required_time = @course.required_time


        # シフトが枠単位で空いているかどうか判定する配列を作成
        # 各要素は空いているかどうか(is_free)とそのシフト自体のインスタンス(shifts)のハッシュ
        @shift_range = Time.now.to_date..@shifts.last&.date_time&.to_date
        # 列数(integer)
        @size = @shifts.last&.date_time&.to_date ? @shifts.last&.date_time&.to_date - Time.now.to_date + 1 : 0
        # 二次元配列の初期化
        @shift_is_free = Array.new(48) { Array.new(@size) { { is_free: false, shift: Shift.new } } }

        make_table(@shifts, @shift_range, @shift_is_free) unless @size == 0
    end

    # 予約登録
    def create
        @reservation = Reservation.new(params[:reservation])
        # 予約するシフトの先頭
        initial_time = @reservation.reserved_date
        # 予約するシフトの配列
        shifts = []
        # 予約するシフトを取り出し、すでに予約が入っているシフトがあればやりなおし
        @reservation.reserved_time.times do |i|
            shift = Shift.find_by(stylist_id: params[:stylist_id],
                                  date_time: initial_time.since(30.minutes * i))
            shifts.push(shift)
            unless shift.reservation_id.nil?
                redirect_to new_reservation_path(stylist_id: params[:stylist_id],
                                                 course_id: @reservation.course_id),
                            notice: "予約できませんでした。別の時間帯をお選びください。"
                return
            end
        end
        if @reservation.save
            # shiftテーブルのインスタンスに関連付け
            shifts.each do |shift|
                shift.update(reservation_id: @reservation.id)
            end
            redirect_to :reservations, notice: "予約を確定しました。"
        else
            flash[:alert] = @reservation.errors.full_messages.join(', ')
            redirect_to :root
        end
    end

    # 予約キャンセル
    def destroy
        @reservation = Reservation.find_by(id: params[:id])
        @reservation&.destroy
        redirect_to :reservations, notice: "予約をキャンセルしました。"
    end
end