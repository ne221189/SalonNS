class Admin::ReservationsController < Admin::Base
    # ログインを要求
    before_action :admin_login_required
    def index
        @reservations = Reservation.order(:id)

        # 終わったものとそうでないものの仕分け
        @coming = []
        @finished = []
        @reservations.each do |reservation|
            if reservation.reserved_date < Time.current
                @finished.push(reservation)
            else
                @coming.push(reservation)
            end
        end
    end

    # 予約キャンセル
    def destroy
        shifts = @reservation.shifts
        shifts.each do |shift|
            shift.update(reservation_id: nil)
        end
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to :reservations, notice: "予約を削除しました。"
    end
end
