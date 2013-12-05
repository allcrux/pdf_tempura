module PdfTempura
  module Render
    class Field::TableAnnotationRenderer < Field::AnnotationRenderer
      protected
      
      def transparency
        0.25
      end
      
      def coordinate_offsets
        return {
          :xy => [1,8],
          :label => [1,-9]
        }
      end

    end
  end
end