module SvgHelper
  def inline_svg(filename, options = {})
    return "".html_safe unless filename.present?

    file_path = Rails.root.join("app/assets/images/svg", "#{filename}.svg")

    unless File.exist?(file_path)
      return "(SVG not found: #{filename})".html_safe
    end

    begin
      svg_content = File.read(file_path)
      doc = Nokogiri::HTML::DocumentFragment.parse(svg_content)
      svg = doc.at_css("svg")

      if svg.present?
        # SVG属性を設定
        options.each do |key, value|
          next if key == :class
          svg[key.to_s] = value
        end

        # CSSクラスを追加
        if options[:class].present?
          svg["class"] = [ svg["class"], options[:class] ].compact.join(" ")
        end

        # sanitizeが削除しすぎている可能性があるので、直接html_safeを使用
        doc.to_html.html_safe
      else
        # SVG要素が見つからない場合は元のコンテンツを返す
        svg_content.html_safe
      end
    rescue => e
      Rails.logger.error("SVG Error: #{e.message}")
      "<!-- SVG Error: #{e.message} -->".html_safe
    end
  end
end
