class GameSerializer < ActiveModel::Serializer
  attributes :cells,
             :columns_size,
             :created_at,
             :end_time,
             :flagged_cells,
             :id,
             :mines_amount,
             :opened_cells,
             :rows_size,
             :start_time,
             :status
end
