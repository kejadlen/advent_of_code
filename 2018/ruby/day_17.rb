require "minitest"
require "minitest/pride"

class Slice
  def self.parse(s)
    squares = {}
    s.scan(/^(x|y)=(\d+), (?:x|y)=(\d+)..(\d+)$/m).each do |xy, i, min, max|
      i, min, max = [i, min, max].map(&:to_i)
      (min..max).map {|j| xy == ?x ? [i, j] : [j, i] }.each do |pos|
        squares[pos] = ?#
      end
    end
    new(squares)
  end

  def initialize(squares)
    @squares = squares
    @squares[[500, 0]] = ?+
  end

  def simulate

  end

  def to_s
    min_x, max_x = @squares.keys.map(&:first).minmax
    min_y, max_y = @squares.keys.map(&:last).minmax
    min_y = [0, min_y].min
    (min_y..max_y).map {|y| (min_x-1..max_x+1).map {|x| @squares.fetch([x, y]) { ?. } }.join }.join(?\n)
  end
end

class TestSlice < Minitest::Test
  def test_parse_to_s
    slice = Slice.parse(<<~SLICE)
      x=495, y=2..7
      y=7, x=495..501
      x=501, y=3..7
      x=498, y=2..4
      x=506, y=1..2
      x=498, y=10..13
      x=504, y=10..13
      y=13, x=498..504
    SLICE

    assert_equal <<~SLICE.chomp, slice.to_s
      ......+.......
      ............#.
      .#..#.......#.
      .#..#..#......
      .#..#..#......
      .#.....#......
      .#.....#......
      .#######......
      ..............
      ..............
      ....#.....#...
      ....#.....#...
      ....#.....#...
      ....#######...
    SLICE
  end
end

def solve(input)
end

if __FILE__ == $0
  require "minitest/autorun" and exit if ENV["TEST"]

  puts solve(ARGF.read)
end
