Rails.application.routes.draw do
    root "top#index"

    # salonリソースの設定
    resources :salons, except: [:new, :create, :edit, :update, :destroy] do
        patch "like", "unlike", on: :member
        get "voted", on: :collection
        get "search", on: :collection
    end

    # reservationsリソースの設定
    resources :reservations, except: [:show, :edit, :update]

    # sessionリソースの設定(単数)
    resource :session, only: [:create, :destroy]

    # accountリソースの設定(単数)
    resource :account, except: :index

    # passwordリソースの設定(単数)
    resource :password, only: [:show, :edit, :update]

    # 名前空間の設定
    namespace :admin do
        root "top#index"

        # salonsリソースの設定
        resources :salons do
            get "search", on: :collection
        end

        # reservationsリソースの設定
        resources :reservations, only: [:index, :destroy]

        # sessionリソースの設定(単数)
        resource :session, only: [:create, :destroy]
    end

    namespace :owner do
        root "top#index"

        # stylistsリソースの設定
        resources :stylists, except: :show

        # sessionリソースの設定(単数)
        resource :session, only: [:create, :destroy]
    end
end
