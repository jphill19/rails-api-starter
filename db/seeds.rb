# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data to avoid duplicates when seeding
Customer.destroy_all
Subscription.destroy_all
SubscriptionsTea.destroy_all

Rake::Task['tea:fetch_and_store'].invoke

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
  title: "Alice's Monthly Tea Subscription",
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
  title: "Alice's Daily Tea Subscription",
  status: "inactive",
  frequency: "daily",
  customer: customer1
)

teas = Tea.limit(3)

SubscriptionsTea.create!(subscription: subscription1, tea: teas[0])
SubscriptionsTea.create!(subscription: subscription1, tea: teas[1])
SubscriptionsTea.create!(subscription: subscription2, tea: teas[2])
SubscriptionsTea.create!(subscription: subscription2, tea: teas[0])
SubscriptionsTea.create!(subscription: subscription3, tea: teas[1])

puts "Seed data has been created successfully!"
