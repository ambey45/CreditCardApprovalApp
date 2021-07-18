class CreateUserDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :user_details do |t|
      t.text :email
      t.text :pan_card
      t.text :adhar_card
      t.text :account_number
      t.text :account_ifsc
      t.integer :mo_in_flow
      t.integer :mo_out_flow
      t.integer :credit_limit
      t.text :status

      t.timestamps
    end
  end
end
