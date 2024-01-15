class PasswordsController < ApplicationController
    before_action :login_required

    def show
        redirect_to :account
    end

    def edit
        @user = current_customer
    end

    def update
        @user = current_customer
        current_password = params[:account][:current_password]

        if current_password.present?
            # 現在のパスワードが正しいか確認
            if @user.authenticate(current_password)
                @user.assign_attributes(params[:account])
                if @user.save
                    redirect_to :account, notice: "パスワードを変更しました"
                else
                    render "edit"
                end
            else # 間違っている時のエラー
                @user.errors.add(:current_password, :wrong)
                render "edit"
            end
        else # 空だった時のエラー
            @user.errors.add(:current_password, :empty)
            render "edit"
        end
    end
end
