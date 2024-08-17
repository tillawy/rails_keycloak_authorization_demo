class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.timestamps
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
    end
  end
end
