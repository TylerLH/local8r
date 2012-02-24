class MessagesController < ApplicationController
  def publish
  	## Publish (Send Message)
		$pubnub.publish({
		    :channel => params[:channel],
		    :message => { :location => [ params[:lat], params[:lng] ], :name => params[:username] }
		})

		respond_with :status => 200
  end

  def subscribe
  end

  def history
  end
end
