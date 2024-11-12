class Api::V1::SubscriptionsController < ApplicationController
  def index
    subscriptions = Subscription.all
    render json: SubscriptionSerializer.new(subscriptions, { params: { action: :index } })
  end

  def show
    id = params[:id]
    subscription = Subscription.find(id)

    render json: SubscriptionSerializer.new(subscription, { params: { action: :show } })
  end
end