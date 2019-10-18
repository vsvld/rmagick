require 'rmagick'
require 'minitest/autorun'

module Magick
  def self._tmpnam_
    @@_tmpnam_
  end
end

class Magick::AlphaChannelOption
  def self.enumerators
    @@enumerators
  end
end

class Magick::AlignType
  def self.enumerators
    @@enumerators
  end
end

class Magick::AnchorType
  def self.enumerators
    @@enumerators
  end
end

class MagickUT < Minitest::Test
  def test_colors
    res = nil
    assert_nothing_raised { res = Magick.colors }
    assert_instance_of(Array, res)
    res.each do |c|
      assert_instance_of(Magick::Color, c)
      assert_instance_of(String, c.name)
      assert_instance_of(Magick::ComplianceType, c.compliance) unless c.compliance.nil?
      assert_instance_of(Magick::Pixel, c.color)
    end
    Magick.colors { |c| assert_instance_of(Magick::Color, c) }
  end

  # Test a few of the @@enumerator arrays in the Enum subclasses.
  # No need to test all of them.
  def test_enumerators
    ary = nil
    assert_nothing_raised do
      ary = Magick::AlphaChannelOption.enumerators
    end
    assert_instance_of(Array, ary)

    assert_nothing_raised do
      ary = Magick::AlignType.enumerators
    end
    assert_instance_of(Array, ary)
    expect(ary.length).to eq(4)

    assert_nothing_raised do
      ary = Magick::AnchorType.enumerators
    end
    assert_instance_of(Array, ary)
    expect(ary.length).to eq(3)
  end

  def test_features
    res = nil
    assert_nothing_raised { res = Magick::Magick_features }
    assert_instance_of(String, res)
  end

  def test_fonts
    res = nil
    assert_nothing_raised { res = Magick.fonts }
    assert_instance_of(Array, res)
    res.each do |f|
      assert_instance_of(Magick::Font, f)
      assert_instance_of(String, f.name)
      assert_instance_of(String, f.description) unless f.description.nil?
      assert_instance_of(String, f.family)
      assert_instance_of(Magick::StyleType, f.style) unless f.style.nil?
      assert_instance_of(Magick::StretchType, f.stretch) unless f.stretch.nil?
      assert_kind_of(Integer, f.weight)
      assert_instance_of(String, f.encoding) unless f.encoding.nil?
      assert_instance_of(String, f.foundry) unless f.foundry.nil?
      assert_instance_of(String, f.format) unless f.format.nil?
    end
    Magick.fonts { |f| assert_instance_of(Magick::Font, f) }
  end

  def test_geometry
    g = nil
    gs = nil
    g2 = nil
    assert_nothing_raised { g = Magick::Geometry.new }
    assert_nothing_raised { gs = g.to_s }
    expect(gs).to eq('')

    g = Magick::Geometry.new(40)
    gs = g.to_s
    expect(gs).to eq('40x')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50)
    gs = g.to_s
    expect(gs).to eq('40x50')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 10)
    gs = g.to_s
    expect(gs).to eq('40x50+10+0')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 10, -15)
    gs = g.to_s
    expect(gs).to eq('40x50+10-15')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 0, 0, Magick::AreaGeometry)
    gs = g.to_s
    expect(gs).to eq('40x50@')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 0, 0, Magick::AspectGeometry)
    gs = g.to_s
    expect(gs).to eq('40x50!')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 0, 0, Magick::LessGeometry)
    gs = g.to_s
    expect(gs).to eq('40x50<')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 0, 0, Magick::GreaterGeometry)
    gs = g.to_s
    expect(gs).to eq('40x50>')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 50, 0, 0, Magick::MinimumGeometry)
    gs = g.to_s
    expect(gs).to eq('40x50^')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 0, 0, 0, Magick::PercentGeometry)
    gs = g.to_s
    expect(gs).to eq('40%')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 60, 0, 0, Magick::PercentGeometry)
    gs = g.to_s
    expect(gs).to eq('40%x60%')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 60, 10, 0, Magick::PercentGeometry)
    gs = g.to_s
    expect(gs).to eq('40%x60%+10+0')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40, 60, 10, 20, Magick::PercentGeometry)
    gs = g.to_s
    expect(gs).to eq('40%x60%+10+20')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40.5, 60.75)
    gs = g.to_s
    expect(gs).to eq('40.50x60.75')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(40.5, 60.75, 0, 0, Magick::PercentGeometry)
    gs = g.to_s
    expect(gs).to eq('40.50%x60.75%')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(0, 0, 10, 20)
    gs = g.to_s
    expect(gs).to eq('+10+20')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    g = Magick::Geometry.new(0, 0, 10)
    gs = g.to_s
    expect(gs).to eq('+10+0')

    assert_nothing_raised { g2 = Magick::Geometry.from_s(gs) }
    gs2 = g2.to_s
    expect(gs2).to eq(gs)

    # assert behavior with empty string argument
    assert_nothing_raised { g = Magick::Geometry.from_s('') }
    expect(g.to_s).to eq('')

    assert_raise(ArgumentError) { Magick::Geometry.new(Magick::AreaGeometry) }
    assert_raise(ArgumentError) { Magick::Geometry.new(40, Magick::AreaGeometry) }
    assert_raise(ArgumentError) { Magick::Geometry.new(40, 20, Magick::AreaGeometry) }
    assert_raise(ArgumentError) { Magick::Geometry.new(40, 20, 10, Magick::AreaGeometry) }
  end

  def test_init_formats
    assert_instance_of(Hash, Magick.init_formats)
  end

  def test_opaque_alpha
    expect(Magick::OpaqueAlpha).to eq(Magick::QuantumRange)
  end

  def test_set_log_event_mask
    assert_nothing_raised { Magick.set_log_event_mask('Module,Coder') }
    assert_nothing_raised { Magick.set_log_event_mask('None') }
  end

  def test_set_log_format
    assert_nothing_raised { Magick.set_log_format('format %d%e%f') }
  end

  def test_limit_resources
    cur = new = nil

    assert_nothing_raised { cur = Magick.limit_resource(:memory, 500) }
    assert_kind_of(Integer, cur)
    assert(cur > 1024**2)
    assert_nothing_raised { new = Magick.limit_resource('memory') }
    expect(new).to eq(500)
    Magick.limit_resource(:memory, cur)

    assert_nothing_raised { cur = Magick.limit_resource(:map, 3500) }
    assert_kind_of(Integer, cur)
    assert(cur > 1024**2)
    assert_nothing_raised { new = Magick.limit_resource('map') }
    expect(new).to eq(3500)
    Magick.limit_resource(:map, cur)

    assert_nothing_raised { cur = Magick.limit_resource(:disk, 3 * 1024 * 1024 * 1024) }
    assert_kind_of(Integer, cur)
    assert(cur > 1024**2)
    assert_nothing_raised { new = Magick.limit_resource('disk') }
    expect(new).to eq(3_221_225_472)
    Magick.limit_resource(:disk, cur)

    assert_nothing_raised { cur = Magick.limit_resource(:file, 500) }
    assert_kind_of(Integer, cur)
    assert(cur > 512)
    assert_nothing_raised { new = Magick.limit_resource('file') }
    expect(new).to eq(500)
    Magick.limit_resource(:file, cur)

    assert_nothing_raised { cur = Magick.limit_resource(:time, 300) }
    assert_kind_of(Integer, cur)
    assert(cur > 300)
    assert_nothing_raised { new = Magick.limit_resource('time') }
    expect(new).to eq(300)
    Magick.limit_resource(:time, cur)

    assert_raise(ArgumentError) { Magick.limit_resource(:xxx) }
    assert_raise(ArgumentError) { Magick.limit_resource('xxx') }
    assert_raise(ArgumentError) { Magick.limit_resource('map', 3500, 2) }
    assert_raise(ArgumentError) { Magick.limit_resource }
  end

  def test_transparent_alpha
    expect(Magick::TransparentAlpha).to eq(0)
  end
end

Test::Unit::UI::Console::TestRunner.run(MagickUT) if $PROGRAM_NAME == __FILE__
