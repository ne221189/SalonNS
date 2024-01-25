class Owner::StylistsController < Owner::Base
    before_action :owner_login_required
    def index
        @stylists = current_owner.salon&.stylists
    end

    def show
      @stylist = Stylist.find_by(id: params[:id])
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
        @stylist = Stylist.find_by(id: params[:id])
        @stylist.shifts.each do |shift|
            if !shift.reservation_id.nil? and shift.date_time >= Time.now
                redirect_to [:owner, :stylists], notice: "予約がある状態では削除できません"
                return
            end
        end
        @stylist&.destroy
        redirect_to :owner_stylists, notice: "スタイリストを削除しました。"
    end
end
