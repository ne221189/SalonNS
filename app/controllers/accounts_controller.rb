class AccountsController < ApplicationController
    before_action :login_required

    def show
        # ログイン中のユーザー
        @user = current_user
    end

    def edit
        @user = current_user
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
end
