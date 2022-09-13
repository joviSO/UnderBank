class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.belongs_to :client
      t.float :balance,         null: false, default: 0
      t.integer :agency,        null: false, default: 1

      t.timestamps
    end
  end
end
