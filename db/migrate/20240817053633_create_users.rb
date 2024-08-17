class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: false do |t|
      t.primary_key :id, :string, default: -> { "lower(hex(randomblob(16)))" }
      t.string :email, null: false, index: { unique: true }
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
