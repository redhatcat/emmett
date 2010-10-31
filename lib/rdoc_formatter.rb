require 'rdoc/markup/to_html'

class RdocFormatter
  def initialize(s)
    @string = s
  end

  def to_html
    RDoc::Markup::ToHtml.new.convert(@string)
  end
end
