class Owner::TopController < Owner::Base
  def index
      @salon = current_owner&.salon
  end
end
