class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.float :transaction_value
      t.string :transaction_kind
      t.string :depositor_name
      t.string :depositor_phone
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
