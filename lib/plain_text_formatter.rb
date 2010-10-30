class PlainTextFormatter
  def initialize(s)
    @string = s
  end

  def to_html
    ERB::Util.html_escape(@string)
  end
end
