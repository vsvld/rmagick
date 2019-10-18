require 'rmagick'
require 'minitest/autorun'

class PreviewUT < Minitest::Test
  def test_preview
    hat = Magick::Image.read(IMAGES_DIR + '/Flower_Hat.jpg').first
    assert_nothing_raised do
      prev = hat.preview(Magick::RotatePreview)
      assert_instance_of(Magick::Image, prev)
    end
    Magick::PreviewType.values do |type|
      assert_nothing_raised { hat.preview(type) }
    end
    expect { hat.preview(2) }.to raise_error(TypeError)
  end
end

if $PROGRAM_NAME == __FILE__
  IMAGES_DIR = '../doc/ex/images'
  Test::Unit::UI::Console::TestRunner.run(PreviewUT)
end
