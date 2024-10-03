# app/controllers/subscriptions_controller.rb
class SubscriptionsController < ApplicationController
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.ip_address = request.remote_ip
    @subscription.user_agent = request.user_agent

    if @subscription.save
      # TODO: Send welcome email (consider using a background job)
      flash[:success] = "Thank you for subscribing!"
      redirect_to root_path # Redirect to the home page or wherever the form is
    else
      flash[:error] = @subscription.errors.full_messages.to_sentence
      redirect_to root_path # Redirect back to the form
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
