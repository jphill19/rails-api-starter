SubscriptionsTea.destroy_all
Subscription.destroy_all
Customer.destroy_all


Rake::Task['tea:fetch_and_store'].invoke

# Create customers
customer1 = Customer.create!(
  first_name: "John",
  last_name: "Hill",
  email: "john@example.com",
  address: "123 Tea Lane, Teatown"
)

customer2 = Customer.create!(
  first_name: "Bob",
  last_name: "Smith",
  email: "bob@example.com",
  address: "456 Herbal St, Herbville"
)


subscription1 = Subscription.create!(
  title: "Johns Monthy Tea",
  status: "active",
  frequency: "monthly",
  customer: customer1
)

subscription2 = Subscription.create!(
  title: "Bob's Weekly Tea Subscription",
  status: "active",
  frequency: "weekly",
  customer: customer2
)

subscription3 = Subscription.create!(
  title: "John's Daily Tea Subscription",
  status: "inactive",
  frequency: "daily",
  customer: customer1
)


subscription4 = Subscription.create!(
  title: "Bob's Variety Tea Subscription",
  status: "active",
  frequency: "monthly",
  customer: customer2
)


teas = Tea.limit(3)


SubscriptionsTea.create!(subscription: subscription1, tea: teas[0])
SubscriptionsTea.create!(subscription: subscription1, tea: teas[1])
SubscriptionsTea.create!(subscription: subscription2, tea: teas[2])
SubscriptionsTea.create!(subscription: subscription2, tea: teas[0])
SubscriptionsTea.create!(subscription: subscription3, tea: teas[1])


SubscriptionsTea.create!(subscription: subscription4, tea: teas[0])
SubscriptionsTea.create!(subscription: subscription4, tea: teas[1])
SubscriptionsTea.create!(subscription: subscription4, tea: teas[2])

puts "Seed data has been created successfully!"
