class Admin::SalonsController < Admin::Base
    # ログインを要求
    before_action :admin_login_required
    # 会員一覧
    def index
        @salons = Salon.order("id")
    end

    def search
        @salons = Salon.search(params[:q])
        render "index"
    end

    def show
        @salon = Salon.find(params[:id])

        @stylists = @salon.stylists
    end

    # 新規作成フォーム
    def new
        @salon = Salon.new
    end

    # 更新フォーム
    def edit
        @salon = Salon.find(params[:id])
    end

    # 会員の新規登録
    def create
        @salon = Salon.new(params[:salon])
        if @salon.save
            redirect_to [:admin, @salon], notice: "新規美容院を登録しました"
        else
            render "new"
        end
    end

    # 会員情報の更新
    def update
        @salon = Salon.find(params[:id])
        @salon.assign_attributes(params[:salon])
        if @salon.save
            redirect_to [:admin, @salon], notice: "美容院情報を更新しました。"
        else
            render "edit"
        end
    end

    def destroy
        @salon = Salon.find(params[:id])
        @salon.destroy
        redirect_to :admin_salons, notice: "美容院を削除しました。"
    end
end
