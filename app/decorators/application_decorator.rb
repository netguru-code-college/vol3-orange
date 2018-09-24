class ApplicationDecorator < Draper::Decorator
  delegate_all

  def formatted_start_date
    (object.start_date).strftime("%d/%m/%Y")
  end

  def formatted_end_date
    (object.start_date).strftime("%d/%m/%Y")
  end
end
