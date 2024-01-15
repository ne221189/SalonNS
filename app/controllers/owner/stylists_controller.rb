class Owner::StylistsController < Owner::Base
  def index
      @stylists = current_owner.salon&.stylists

      reservations = Reservation.order(:reserved_date)


      @res_cnt = 0
      reservations.each do |reservation|
          @res_cnt += 1 if reservation.shifts.first&.stylist&.salon_id == current_owner.salon_id
      end
  end

  def new
      @stylist = Stylist.new
  end

  # スタイリストの新規登録
  def create
      @stylist = Stylist.new(params[:stylist])
      if @stylist.save
          redirect_to [:owner, :stylists], notice: "新規スタイリストを登録しました"
      else
          render "new"
      end
  end

  def edit
      @stylist = Stylist.find(params[:id])
  end

  def update
      @stylist = Stylist.find(params[:id])
      @stylist.assign_attributes(params[:stylist])
      if @stylist.save
          redirect_to [:owner, :stylists], notice: "スタイリスト情報を更新しました。"
      else
          render "edit"
      end
  end

  def destroy
      @stylist = Stylist.find(params[:id])
      @stylist.destroy
      redirect_to :owner_stylists, notice: "スタイリストを削除しました。"
  end
end
