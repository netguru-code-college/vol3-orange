require 'rails_helper'

RSpec.describe SetDateService, type: :service do
  let(:trip) { build(:trip) }
  subject { described_class.new(trip)}

  it 'changes start_date to midnight' do
    previous_start_date = trip.start_date
    expect{ subject.call }.to change{
      trip.start_date }
      .from(previous_start_date)
      .to(previous_start_date.midnight)
  end

  it 'changes end_date to midnight' do
    previous_end_date = trip.end_date
    expect{ subject.call }.to change{
      trip.end_date }
      .from(previous_end_date)
      .to(previous_end_date.midnight)
  end
end
