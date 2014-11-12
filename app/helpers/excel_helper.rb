module ExcelHelper
  def fetch_date(month, year)
    "#{Date::MONTHNAMES[month.to_i]}, #{year}"
  end

  def extract_prf_dep(value)
    value.split('_').join('/')
  end
end
