module Jekyll
  class RenderTooltipTag < Liquid::Block

    CaptionUrl = /(\S[\S\s]*)\s+(https?:\/\/\S+)\s+(.+)/i
    Caption = /(\S[\S\s]*)/

    def initialize(tag_name, markup, tokens)
      super
      @caption = markup
      @markup = markup
    end

    def render(context)
      site = context.registers[:site]
      converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      output = converter.convert(super(context))
      caption = converter.convert(@caption)
      "<a href=\"#\" onclick=\"return false;\" data-toggle=\"popover\" data-placement=\"top\" data-trigger=\"focus\" data-content=\"#{@caption}\">#{super(context)}</a>"
    end
  end
end

Liquid::Template.register_tag('tooltip', Jekyll::RenderTooltipTag)
