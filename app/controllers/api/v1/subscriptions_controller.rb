class Api::V1::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

  def index
    subscriptions = Subscription.all
    render json: SubscriptionSerializer.new(subscriptions, { params: { action: :index } })
  end

  def show
    id = params[:id]
    subscription = Subscription.find(id)

    render json: SubscriptionSerializer.new(subscription, { params: { action: :show } })
  end

  def update
    id = params[:id]
    subscription = Subscription.find(id)
    subscription.update!(subscription_params)

    render json: SubscriptionSerializer.new(subscription, { params: { action: :update } })
  end
  
  private

  def subscription_params
    params.require(:subscription).permit(:status)
  end

  def render_validation_error(exception)
    error_message = ErrorMessage.new(exception.record.errors.full_messages.join(", "), 404)
    render json: ErrorSerializer.format_error(error_message), status: :not_found
  end
end