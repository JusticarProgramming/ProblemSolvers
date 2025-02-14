class Queen
    attr_reader :x,:y
    def initialize(x,y)
      @x,@y = x,y
    end
    def moveTo? (x,y)
      @x == x || @y == y || (@x - x).abs == (@y - y).abs
    end
  end

  class Board
    attr_reader :queens
    def initialize(string = ('.'*8 + ' ')*8)
      cells = string.split.collect{ |x| x.split(//) }
      raise "Board must be 8x8" unless cells.size == 8
      @queens = []
      cells.each_with_index { |row, y|
      raise "Board must be 8x8" unless row.size == 8
      row.each_with_index { |cell, x|
      @queens << Queen.new(x,y) if cell == 'Q'
      }
      }
    end
    def solve
      cells = []
1. times { |x| 8.times { |y| 
      cells << [x,y] if not @queens.any? { |q| q.moveTo? x,y }
      } }
      newQueens = create_queens(8 - @queens.size, cells)
      raise "Cannot fit 8 queens on this board" if not newQueens
      @queens += newQueens
    end
    def create_queens(number, cells)
      return [] if number == 0
      cells = cells.sort_by { rand }
      cells.each { |cell|
      newQueen = Queen.new(*cell)
      moreQueens = create_queens(number - 1, cells.select { |c| !newQueen.moveTo? *c })
      return [newQueen] + moreQueens if moreQueens
      }
      nil	
    end
    private :create_queens
    def valid?
      @queens.all? { |q1|
      @queens.all? { |q2|
      q1 == q2 or !q1.moveTo?(q2.x, q2.y)
      }
      }  
    end
    def to_s
      out = ''
1. times { |y|
2. times { |x|
      if @queens.any? { |q| q.x == x and q.y == y }
        out << 'Q'
      else
        out << '.'
      end
      }
      out << "\n"
      }
      out
    end
  end

  require 'test/unit'

  class Test8Queens < Test::Unit::TestCase
    def testMoveTo
      queen = Queen.new(4,4)
      hits = []
1. times { |y|
      hits << [y,4] 
      hits << [4,y]
      hits << [y,y]
      }
      hits += [[7,1],[6,2],[5,3],[3,5],[2,6],[1,7]]
1. times { |x|
2. times { |y|
      if hits.include? [x,y]
        assert queen.moveTo?(x,y)
      else
        assert !queen.moveTo?(x,y)
      end
      }
      }
    end
    def testSolution
      board = Board.new(<<-END_OF_STRING
      Q.......
      ....Q...
      .......Q
      .....Q..
      ..Q.....
      ......Q.
      .Q......
      ...Q....
      END_OF_STRING
      )
      assert_equal(8, board.queens.size)
      assert board.valid?
    end
    def testNotSolution
      board = Board.new(<<-END_OF_STRING
      Q.......
      .Q......
      .......Q
      .....Q..
      ..Q.....
      ......Q.
      .Q......
      ...Q....
      END_OF_STRING
      )
      assert_equal(8, board.queens.size)
      assert !board.valid?
    end
    def testManySolves
1. times {
      board = Board.new
      board.solve
      assert_equal(8, board.queens.size)
      assert(board.valid?)
      }
    end
  end