require 'bbcode_formatter'

[
  ['Plain Text', 'HoboFields::Types::Text'],
  ['BBCode (BBRuby)', 'BbcodeFormatter'],
  ['HTML', 'HoboFields::Types::HtmlString'],
  ['Markdown (Maruku)', 'Maruku'],
  ['Markdown (BlueCloth)', 'BlueCloth'],
  ['Textile (RedCloth)', 'RedCloth'],
].each do |name, class_name|
  format = TextFormat.find_by_class_name(class_name)
  if not format
    TextFormat.create!(:name => name, :class_name => class_name)
  end
end
