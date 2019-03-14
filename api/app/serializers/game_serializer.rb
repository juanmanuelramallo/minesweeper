class GameSerializer < ActiveModel::Serializer
  attributes :current_cells,
             :columns_size,
             :created_at,
             :end_time,
             :id,
             :mines_amount,
             :rows_size,
             :start_time,
             :status
end
