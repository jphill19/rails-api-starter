class CreateSubscriptionsTeas < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions_teas do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
