FactoryBot.define do
  factory :game do
    start_time { DateTime.now.utc }
    # columns_size { 3 }
    # rows_size { 3 }
    # mines_amount { 1 }
    user
  end
end
