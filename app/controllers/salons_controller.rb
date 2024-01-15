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

    def like
        @salon = Salon.find(params[:id])
        current_customer.voted_salons << @salon
        redirect_to @salon, notice: "お気に入りに登録しました"
    rescue
        redirect_to @salon
    end

    # 投票削除
    def unlike
        current_customer.voted_salons.destroy(Salon.find(params[:id]))
        redirect_to :account, notice: "お気に入りから削除しました"
    end
end
