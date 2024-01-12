class SalonsController < ApplicationController
    # 美容院一覧
    def index
        @salons = Salon.order("id")
    end

    # 美容院詳細
    def show
        @salon = Salon.find(params[:id])
        @reservation = Reservation.new
    end

    # 美容院検索機能
    def search
        @salons = Salon.search(params[:q])
        render "index"
    end
end
