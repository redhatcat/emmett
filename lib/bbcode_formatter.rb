class BbcodeFormatter
  def initialize(s)
    @string = s
  end

  def to_html
    BBRuby.to_html(@string)
  end
end
