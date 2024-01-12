Rails.application.routes.draw do
    root "top#index"

    # salonリソースの設定
    resources :salons do
        get "search", on: :collection
    end

    # reservationsリソースの設定
    resources :reservations

    # sessionリソースの設定(単数)
    resource :session, only: [:create, :destroy]

    # accountリソースの設定(単数)
    resource :account, only: [:new, :create, :show, :edit, :update]

    # passwordリソースの設定(単数)
    resource :password, only: [:show, :edit, :update]

    # 名前空間の設定
    namespace :admin do
        root "top#index"
    end

    namespace :own do
        root "top#index"
    end
end
