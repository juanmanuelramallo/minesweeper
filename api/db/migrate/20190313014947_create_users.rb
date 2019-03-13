class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.uuid :uuid, null: false

      t.timestamps
    end

    add_index :users, :uuid, unique: true
  end
end
