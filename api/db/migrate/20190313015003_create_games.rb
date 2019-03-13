class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :cells, array: true
      t.integer :opened_cells, array: true
      t.integer :flagged_cells, array: true
      t.integer :status
      t.references :user, index: true

      t.timestamps
    end
  end
end
