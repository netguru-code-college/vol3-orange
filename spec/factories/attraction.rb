FactoryBot.define do
  factory :attraction do
    name { 'Tokio Odaiba' }
    start_date { Time.now }
    end_date { start_date + 1.day }
    place
  end
end
