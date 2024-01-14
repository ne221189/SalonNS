class Admin::ReservationsController < Admin::Base
    # ログインを要求
    before_action :admin_login_required
    def index
        @reservations = Reservation.order(:id)

        # 終わったものとそうでないものの仕分け(予約先のシフトが欠損している場合も同じ扱い)
        @coming = []
        @finished = []
        @reservations.each do |reservation|
            if reservation.reserved_date < Time.current or reservation.shifts.first&.stylist&.salon.nil? or reservation.shifts.length < reservation.reserved_time
                @finished.push(reservation)
            else
                @coming.push(reservation)
            end
        end
    end

    # 予約キャンセル
    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to :admin_reservations, notice: "予約を削除しました。"
    end
end
