class CreateSecrets < ActiveRecord::Migration[7.2]
  def change
    create_table :secrets do |t|
      t.string :name

      t.timestamps
    end
  end
end
