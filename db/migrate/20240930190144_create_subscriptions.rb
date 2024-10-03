class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false
      t.string :status, null: false, default: 'pending'
      t.datetime :subscribed_at
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end

    add_index :subscriptions, :email, unique: true
  end
end
