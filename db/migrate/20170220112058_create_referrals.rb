class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :code
      t.datetime :expiry_date

      t.timestamps null: false
    end
  end
end
