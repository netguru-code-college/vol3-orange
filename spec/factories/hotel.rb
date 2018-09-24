FactoryBot.define do
  factory :hotel do
    name { 'Tokio Hostel' }
    start_date { Time.now }
    end_date { start_date + 1.day }
    place
  end
end
