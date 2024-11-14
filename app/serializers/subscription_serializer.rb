class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title, :status, :frequency, :customer_id

  attribute :customer_id, if: proc { |record, params|
    params[:action] != :show
  }

  attribute :teas_count, if: proc { |record, params| params[:action] == :index } do |subscription|
    subscription.teas.count
  end

  attribute :price do |subscription|
    subscription.price.to_f
  end

  
  attribute :customer, if: proc { |record, params| params[:action] == :show } do |subscription|
    {
      id: subscription.customer.id,
      first_name: subscription.customer.first_name,
      last_name: subscription.customer.last_name,
      email: subscription.customer.email,
      address: subscription.customer.address
    }
  end

  attribute :teas, if: proc { |record, params| params[:action] == :show } do |subscription|
    subscription.teas.map do |tea|
      {
        id: tea.id,
        title: tea.title,
        description: tea.description,
        price: tea.price.to_f,
        temperature: tea.temperature,
        brew_time: tea.brew_time,
        image: tea.image
      }
    end
  end
end
