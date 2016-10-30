class CreateReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :receipts do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :ticket_type_id, foreign_key: true
      t.integer :quantity
    end
  end
end
