require 'rmagick'
require 'minitest/autorun'

class PreviewUT < Minitest::Test
  def test_preview
    hat = Magick::Image.read(IMAGES_DIR + '/Flower_Hat.jpg').first
    expect do
      prev = hat.preview(Magick::RotatePreview)
      expect(prev).to be_instance_of(Magick::Image)
    end.not_to raise_error
    Magick::PreviewType.values do |type|
      expect { hat.preview(type) }.not_to raise_error
    end
    expect { hat.preview(2) }.to raise_error(TypeError)
  end
end

if $PROGRAM_NAME == __FILE__
  IMAGES_DIR = '../doc/ex/images'
  Test::Unit::UI::Console::TestRunner.run(PreviewUT)
end
