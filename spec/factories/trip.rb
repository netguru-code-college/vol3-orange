FactoryBot.define do
  factory :trip do
    name { 'Nice trip' }
    start_date { Time.now }
    end_date { start_date + 10.days }
    after :create do |trip|
      create_list :place, 3, trip: trip
    end
  end
end
