class SetDateService
  def initialize(object)
    @object = object
  end

  def call
    @object.start_date = @object.start_date.midnight
    @object.end_date = @object.end_date.midnight
  end
end
