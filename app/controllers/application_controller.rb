class ApplicationController < ActionController::Base
    # 予約の仕分け
    private def sort_reservations(reservations)
        coming = []
        finished = []
        reservations.each do |reservation|
            if reservation.reserved_date < Time.current or reservation.shifts.first&.stylist&.salon.nil? or reservation.shifts.length < reservation.reserved_time
                finished.push(reservation)
            else
                coming.push(reservation)
            end
        end
        [coming, finished]
    end

    # ログインしている利用者
    private def current_customer
        Customer.find_by(id: session[:customer_id]) if session[:customer_id]
    end
    helper_method :current_customer

    private def current_owner
        Owner.find_by(id: session[:owner_id]) if session[:owner_id]
    end
    helper_method :current_owner

    private def current_administrator
        Administrator.find_by(id: session[:administrator_id]) if session[:administrator_id]
    end
    helper_method :current_administrator

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    # エラーの時実行するメソッドを指定
    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end
    rescue_from LoginRequired, with: :rescue_login_required
    rescue_from Forbidden, with: :rescue_forbidden

    # エラーの時実行するメソッド
    private def login_required
        raise LoginRequired unless current_customer
    end

    private def rescue_bad_request(exception)
        render "errors/bad_request", status: 400, layout: "error",
               formats: [:html]
    end

    private def rescue_login_required(exception)
        render "errors/login_required", status: 403, layout: "error",
               formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",
               formats: [:html]
    end

    private def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error",
               formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",
               formats: [:html]
    end
end
