class DatesRangeValidatorService
  def initialize(object:, kind:)
    @object = object
    @kind = kind
  end

  def call
    add_too_early_error if wrong_start_date
    add_too_late_error if wrong_end_date
  end

  private

  def wrong_start_date
    @object.send(@kind).start_date > @object.start_date
  end

  def wrong_end_date
    @object.send(@kind).end_date < @object.end_date
  end

  def add_too_early_error
    @object.errors.add(
      :start_date,
      "can't be earlier than #{ @object.send(@kind).start_date }"
    )
  end

  def add_too_late_error
    @object.errors.add(
      :end_date,
      "can't be later than #{ @object.send(@kind).end_date }")
  end
end
