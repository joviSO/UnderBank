class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.float :balance,             null: false, default: 0
      t.integer :agency,            null: false, default: 1
      t.references :client,         null: false, foreign_key: true

      t.timestamps
    end
  end
end
