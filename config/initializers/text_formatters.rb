require 'bbcode_formatter'
require 'html_formatter'
require 'plain_text_formatter'

[
  ['Plain Text', 'PlainTextFormatter'],
  ['BBCode (BBRuby)', 'BbcodeFormatter'],
  ['HTML', 'HtmlFormatter'],
  ['Markdown (Maruku)', 'Maruku'],
  ['Markdown (BlueCloth)', 'BlueCloth'],
  ['Textile (RedCloth)', 'RedCloth'],
].each do |name, class_name|
  format = TextFormat.find_by_class_name(class_name)
  if not format
    TextFormat.create!(:name => name, :class_name => class_name)
  end
end
