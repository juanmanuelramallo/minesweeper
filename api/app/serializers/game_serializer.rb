class GameSerializer < ActiveModel::Serializer
  attributes :current_cells,
             :columns_size,
             :created_at,
             :end_time,
             :flagged_cells,
             :id,
             :mines_amount,
             :rows_size,
             :start_time,
             :status
end
