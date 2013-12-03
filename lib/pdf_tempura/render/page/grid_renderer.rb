module PdfTempura
  module Render
    class Page::GridRenderer

      def render(pdf)

        pdf.stroke_color = "000000"
        pdf.fill_color = "000000"
        pdf.line_width = 0.5
        pdf.transparent(0.125) do
          line_loop(pdf.bounds.width, 25) do |x|
            vertical_line_with_label pdf, x
          end
          line_loop(pdf.bounds.height, 25) do |y|
            horizontal_line_with_label pdf, y
          end
        end

      end

      private

      def line_loop(max, increment)
        n = 0
        while n <= max
          yield(n)
          n += increment
        end
      end

      def vertical_line_with_label(pdf, x)
        pdf.stroke do
          pdf.line([x, 0], [x, pdf.bounds.height])
          pdf.draw_text x.to_s, at: [x+3, 3], size: 6
        end
      end

      def horizontal_line_with_label(pdf, y)
        pdf.stroke do
          pdf.line([0, y], [pdf.bounds.width, y])
          pdf.draw_text y.to_s, at: [3, y+3], size: 6
        end
      end

    end
  end
end