class AccountsController < ApplicationController
    before_action :login_required, except: [:new, :create]

    def show
        # ログイン中のユーザー
        @user = current_customer
        @voted_salons = @user.voted_salons
                          .order("votes.created_at DESC")
    end

    def new
        @user = Customer.new
    end

    def edit
        @user = current_customer
    end

    def create
        @user = Customer.new(params[:account])
        if @user.save
            session[:customer_id] = @user.id # 登録したらログイン状態にする
            redirect_to root_path, notice: "アカウントを新規登録しました"
        else
            render "new"
        end
    end
    def update
        @user = Customer.find(params[:user_id])
        @user.assign_attributes(params[:account])
        if @user.save
            redirect_to :account, notice: "アカウント情報を更新しました。"
        else
            render "edit"
        end
    end

    # 退会
    def destroy
        @user = current_customer
        unless sort_reservations(@user.reservations)[0].length == 0
            @user.errors.add(:user, "は予約がある状態では退会できません")
            render "show"
            return
        end
        session.delete(@user.id)
        @user.destroy
        redirect_to :root, notice: "退会しました。"
    end
end
