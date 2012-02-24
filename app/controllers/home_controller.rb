class HomeController < ApplicationController

  def index
    @users = User.all
  end

  def start
  	@user = {
  		:name => params[:name],
  		:latitude => params[:latitude],
  		:longitude => params[:longitude]
  	}

  	unless $redis.sismember "users", params[:name]
  		$redis.sadd "users", params[:name]
      respond_to do |format|
        format.html { redirect_to "/" }
        format.json { render json: { :status => "OK" } }
      end
  	else
  		respond_to do |format|
  			format.json { render json: { :status => 409, :message => "Username already taken!" }}
  		end
  	end
  end

  def stop
  	@user = params[:name]

  	$redis.srem "users", @user

  	respond_to do |format|
  		format.json { render json: {:status => "OK" } }
  	end
  end
end
