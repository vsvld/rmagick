RSpec.describe Magick::Image, '#class_type' do
  it 'does not allow setting to UndefinedClass' do
    img = Magick::Image.new(20, 20)

    expect { img.class_type = Magick::UndefinedClass }
      .to raise_error(ArgumentError, 'Invalid class type specified.')
  end
end
