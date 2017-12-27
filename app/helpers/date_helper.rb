module DateHelper

  def prettify_date(date_object)
    date_object.strftime("%d %B %Y")
  end

end