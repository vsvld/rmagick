require 'rmagick'
require 'minitest/autorun'

class GradientFillUT < Minitest::Test
  def test_new
    expect(Magick::GradientFill.new(0, 0, 0, 100, '#900', '#000')).to be_instance_of(Magick::GradientFill)
    expect(Magick::GradientFill.new(0, 0, 0, 100, 'white', 'red')).to be_instance_of(Magick::GradientFill)

    expect { Magick::GradientFill.new(0, 0, 0, 100, 'foo', '#000') }.to raise_error(ArgumentError)
    expect { Magick::GradientFill.new(0, 0, 0, 100, '#900', 'bar') }.to raise_error(ArgumentError)
    expect { Magick::GradientFill.new('x1', 0, 0, 100, '#900', '#000') }.to raise_error(TypeError)
    expect { Magick::GradientFill.new(0, 'y1', 0, 100, '#900', '#000') }.to raise_error(TypeError)
    expect { Magick::GradientFill.new(0, 0, 'x2', 100, '#900', '#000') }.to raise_error(TypeError)
    expect { Magick::GradientFill.new(0, 0, 0, 'y2', '#900', '#000') }.to raise_error(TypeError)
  end

  def test_fill
    img = Magick::Image.new(10, 10)

    expect do
      gradient = Magick::GradientFill.new(0, 0, 0, 0, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, 0, 0, 10, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, 0, 10, 0, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, 0, 10, 10, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, 0, 5, 20, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(-10, 0, -10, 10, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, -10, 10, -10, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, -10, 10, -20, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error

    expect do
      gradient = Magick::GradientFill.new(0, 100, 100, 200, '#900', '#000')
      obj = gradient.fill(img)
      expect(obj).to eq(gradient)
    end.not_to raise_error
  end
end

class TextureFillUT < Minitest::Test
  def test_new
    granite = Magick::Image.read('granite:').first
    expect(Magick::TextureFill.new(granite)).to be_instance_of(Magick::TextureFill)
  end

  def test_fill
    granite = Magick::Image.read('granite:').first
    texture = Magick::TextureFill.new(granite)

    img = Magick::Image.new(10, 10)
    obj = texture.fill(img)
    expect(obj).to eq(texture)
  end
end
