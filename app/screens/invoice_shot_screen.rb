class InvoiceShotScreen < PM::Screen
  title "Rechnung"

  def on_load
    # After view is first loaded
    set_nav_bar_button :right, title: "Ausschneiden", action: :crop
    @layout = InvoiceShotLayout.new(root: self.view).build
  end

  def crop
    perspectiveCorrection = PerspectiveCorrection.alloc.initWithImage @layout.get(:invoice_image).image
    correctedImage = perspectiveCorrection.correctFromCorners pin_positions_in_image_coordinates
    lines = section_with_tesseract correctedImage
    open ResultScreen.new(image: correctedImage, lines: lines)
  end

  private

  def pin_positions_in_image_coordinates
    quad_size = @layout.get(:quad).bounds.size
    image_size = @layout.get(:invoice_image).image.size

    image_quad_height_ratio = Rational(image_size.height, quad_size.height.to_f)
    image_left_x = @layout.get(:invoice_image).frame.origin.x

    @layout.get(:quad).points.map do |cgpoint|
      [(cgpoint.x - image_left_x) * image_quad_height_ratio, cgpoint.y * image_quad_height_ratio]
    end
  end

  def section_with_tesseract(image)
    ocr = Motion::OCR.new language: "deu"
    hocr = ocr.scan image.CGImage, format: :hocr
    # PM.logger.debug hocr
    Wakizashi::HTML(hocr).xpath("//*[@class='ocr_line']").map do |lineNode|
      line = TextLine.new coordinates_of(lineNode)

      lineNode.xpath("//*[@class='ocr_word']").each do |wordBoxNode|
        text = wordBoxNode.xpath("//*[@class='ocrx_word']").to_s
        line.words << TextWord.new(coordinates_of(wordBoxNode).merge(text: text))
      end

      # Make word frames relative to line position
      line.words.each do |word|
        word.frame[0] = (Vector[*word.frame[0]] - Vector[*line.frame[0]]).to_a
      end

      line
    end

    # tesseract = Tesseract.alloc.initWithLanguage "deu"
    # tesseract.setVariableValue "0123456789aäbcdefghijklmnoöpqrsßtuüvwxyzAÄBCDEFGHIJKLMNOÖPQRSTUÜVWXYZ.-+()/@*,€!", forKey:"tessedit_char_whitelist"
    # tesseract.setImage image
    # tesseract.recognize
    #
    # hocr = tesseract.getHOCRText
    # tesseract.clear
    #
    # HOCRLineParser.parseHOCR hocr
  end

  def coordinates_of(node)
    coords = node[:title].split(' ')[1..4].map(&:to_i)
    {top_left: coords[0..1], bottom_right: coords[2..3]}
  end
end
