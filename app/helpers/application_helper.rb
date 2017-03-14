module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def markdown(text)
    if text.blank?
      nil
    else
      renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        disable_indented_code_blocks: true,
        fenced_code_blocks: true,
        space_after_headers: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
      }
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
  end
end
