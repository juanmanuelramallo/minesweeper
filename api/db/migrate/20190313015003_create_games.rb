class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :end_time
      t.datetime :start_time, null: false
      t.integer :cells, array: true, default: []
      t.integer :flagged_cells, array: true, default: []
      t.integer :opened_cells, array: true, default: []
      t.integer :status, default: 0, null: false
      t.integer :rows_size, null: false
      t.integer :columns_size, null: false
      t.integer :mines_amount, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
