class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :email
      t.string :ticketTypes
      t.string :quantities
      t.string :cost

      t.timestamps
    end
  end
end
