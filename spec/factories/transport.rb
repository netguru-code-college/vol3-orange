FactoryBot.define do
  factory :transport do
    type_of_transport { 'train' }
    start_location { 'Honsiu' }
    start_date { Time.now }
    end_date { start_date + 1.day }
    place
  end
end
