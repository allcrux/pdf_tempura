module PdfTempura
  class Document::Table

    def initialize(name, origin, options = {}, &block)
      @name = name
      (@x, @y) = origin
      @options = options
      @columns = []

      load_options(options)
      instance_eval(&block) if block_given?
    end

    attr_accessor :x, :y, :columns, :name, :row_count, :padding, :cell_padding

    def width
      table_width + padding_width
    end

    def height
      @height ||= row_height * row_count
    end

    def row_height
      @row_height ||= height.to_f / row_count.to_f
    end

    def text_column(name,width,options = {})
      columns << Document::Table::TextColumn.new(name,width,row_height,options)
    end

    def checkbox_column(name,width,options = {})
      columns << Document::Table::CheckboxColumn.new(name,width,row_height,options)
    end

    def spacer(width)
      columns << Document::Table::Spacer.new(width,row_height)
    end

    def fields_for(values, &block)
      values.inject(self.y) do |y, value_hash|
        generate_columns(y, value_hash, &block)
        y - row_height
      end
    end

    private

    def generate_columns(y, values)
      columns.inject(self.x) do |x, column|
        yield column.field_at([x,y]), values[column.name] if column.generates_field?
        x + column.width + cell_padding
      end
    end

    def table_width
      columns.inject(0){ |sum, column| sum + column.width }
    end

    def padding_width
      (columns.any?) ? cell_padding * (columns.count - 1) : 0
    end

    def validate_height
      unless row_count && (@row_height || @height)
        raise ArgumentError.new("You must pass number_of_rows and either height or row_height")
      end
    end

    def load_options(options)
      @height = options[:height]
      @row_height = options[:row_height]
      @row_count = options[:number_of_rows]
      @padding = options[:padding] || [0,0,0,0]
      @cell_padding = options[:cell_padding] || 0

      validate_height
    end

  end
end

require_relative 'table/column'
require_relative 'table/text_column'
require_relative 'table/checkbox_column'
require_relative 'table/spacer'
