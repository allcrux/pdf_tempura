require 'spec_helper'

describe PdfTempura::Extensions::Hash::StringifyKeys do

  subject do
    {
      foo: true,
      bar: {
        blah: "abc"
      },
      woo: [
        1,
        {
          blorgh: false
        }
      ]
    }.extend(described_class)
  end

  describe "#stringify_keys" do
    example do
      result = subject.stringify_keys
      expect(result["foo"]).to be true
      expect(result["bar"]).to eq ({ "blah" => "abc" })
      expect(result["woo"]).to eq ([1, { "blorgh" => false }])

      expect(subject["foo"]).to be nil
      expect(subject["bar"]).to be nil
      expect(subject["woo"]).to be nil
    end
  end

  describe "#stringify_keys!" do
    example do
      subject.stringify_keys!
      expect(subject["foo"]).to be true
      expect(subject["bar"]).to eq ({ "blah" => "abc" })
      expect(subject["woo"]).to eq ([1, { "blorgh" => false }])
    end
  end

end
