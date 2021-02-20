# frozen_string_literal: true

require_relative '../lib/connect_four'

describe Board do
  subject(:testboard) { described_class.new(6, 7) }

  describe '#initialize' do
    context 'When initializing' do
      it 'sets height to 6' do
        expect(testboard.instance_variable_get('@height')).to be 6
      end
      it 'sets width to 7' do
        expect(testboard.instance_variable_get('@width')).to be 7
      end
    end
  end

  describe '#generate_board' do
    context 'After generating board with width 7 and height 6' do
      it 'returns an array of length 6' do
        board = testboard.generate_board(6, 7)
        expect(board.length).to be 6
      end
      it 'returns an array in an array with length 7' do
        board = testboard.generate_board(6, 7)
        expect(board[0].length).to be 7
      end
      it 'all subarrays are empty' do
        array = testboard.generate_board(6, 7)
        empty = true
        array.each do |ary|
          ary.each do |item|
            empty = false unless item.nil?
          end
        end
        expect(empty).to be true
      end
    end
  end

  describe '#check_neighbours' do
    context 'If the following 3 neighbours in given direction are the same as start' do
      xit 'returns the value of the 4 adjacent spots' do
        testboard.instance_variable_set('@board', [
                                          [nil, 'X', 'X', 'X', 'X', nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.check_neighbours(0, 4, :W)).to eq('X')
        expect(testboard.check_neighbours(0, 1, :E)).to eq('X')
        expect(testboard.check_neighbours(0, 2, :E)).to eq(nil)
        expect(testboard.check_neighbours(2, 2, :E)).to eq(nil)
      end
      xit 'returns the value of the 4 adjacent spots' do
        testboard.instance_variable_set('@board', [
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, 'X', nil, nil, nil, nil],
                                          [nil, 'X', nil, nil, nil, nil, nil],
                                          ['X', nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.check_neighbours(1, 3, :SW)).to eq('X')
        expect(testboard.check_neighbours(4, 0, :NE)).to eq('X')
        expect(testboard.check_neighbours(2, 2, :NE)).to eq(nil)
      end
      xit 'returns the value of the 4 adjacent spots' do
        testboard.instance_variable_set('@board', [
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.check_neighbours(0, 4, :S)).to eq('O')
        expect(testboard.check_neighbours(3, 4, :N)).to eq('O')
      end
      xit 'returns the value of the 4 adjacent spots' do
        testboard.instance_variable_set('@board', [
                                          [nil, 'X', 'X', 'X', 'X', nil, nil],
                                          [nil, nil, 'X', nil, nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, nil, 'X', nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.check_neighbours(0, 1, :SE)).to eq('X')
      end
    end

    context 'If checking goes out of bounds' do
      xit 'returns nil' do
        testboard.instance_variable_set('@board', [
                                          ['X', 'X', 'X', nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, nil, 'O', nil, nil]
                                        ])
        expect(testboard.check_neighbours(0, 2, :W)).to eq(nil)
        expect(testboard.check_neighbours(3, 4, :S)).to eq(nil)
        expect(testboard.check_neighbours(6, 3, :S)).to eq(nil)
        expect(testboard.check_neighbours(5, 8, :S)).to eq(nil)
      end
    end
  end

  describe '#in_bounds?' do
    context 'If position is in board' do
      it 'returns true' do
        expect(testboard.in_bounds?(5, 6)).to be true
      end
      it 'returns false' do
        expect(testboard.in_bounds?(8, 8)).to be false
      end
    end
  end

  describe '#winner?' do
    context 'If the board contains four in a row' do
      it 'returns the value of the winning token' do
        testboard.instance_variable_set('@board', [
                                          [nil, 'X', 'X', 'X', 'X', nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.winner?).to eq('X')
      end
    end
    context 'If the doesnt contain for in a row' do
      it 'returns nil' do
        testboard.instance_variable_set('@board', [
                                          [nil, 'X', 'X', 'X', nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.winner?).to eq(nil)
      end
    end
    context 'If the board contains four in a row' do
      it 'returns "O"' do
        testboard.instance_variable_set('@board', [
                                          [nil, 'X', 'X', 'X', nil, nil, 'O'],
                                          [nil, nil, nil, nil, nil, 'O', nil],
                                          [nil, nil, nil, nil, 'O', nil, nil],
                                          [nil, nil, nil, 'O', nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil],
                                          [nil, nil, nil, nil, nil, nil, nil]
                                        ])
        expect(testboard.winner?).to eq('O')
      end
    end
  end

  describe 'column_full?' do
    context 'It checks if a given column is filled to the top' do
      it 'returns true' do
        testboard.instance_variable_set('@board', [
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil]
                                        ])
        expect(testboard.column_full?(3)).to be true
        expect(testboard.column_full?(2)).to be false
      end
    end
  end

  describe 'column_exist?' do
    context 'When given a columnnumber outside the board' do
      it 'returns false' do
        testboard.instance_variable_set('@board', [
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil]
                                        ])
        expect(testboard.column_exist?(-1)).to be false
        expect(testboard.column_exist?(7)).to be false
      end
    end
    context 'When given a columnnumber inside the board' do
      it 'returns true' do
        testboard.instance_variable_set('@board', [
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil],
                                          [nil, nil, nil, '0', nil, nil, nil],
                                          [nil, nil, nil, 'X', nil, nil, nil]
                                        ])
        expect(testboard.column_exist?(0)).to be true
        expect(testboard.column_exist?(6)).to be true
      end
    end
  end

  describe '#add_token' do
    it 'places an token on the lowest spot in the column' do
      testboard.instance_variable_set('@board', [
                                        [nil, nil, nil, nil, nil, nil, nil],
                                        [nil, nil, nil, nil, nil, nil, nil],
                                        [nil, nil, nil, nil, nil, nil, nil],
                                        [nil, nil, nil, nil, nil, nil, nil],
                                        [nil, nil, nil, nil, nil, nil, nil],
                                        [nil, nil, nil, nil, nil, nil, nil]
                                      ])
      testboard.add_token('X', 2)
      expect(testboard.instance_variable_get('@board')).to eql [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 'X', nil, nil, nil, nil]
      ]
      testboard.add_token('O', 2)
      expect(testboard.instance_variable_get('@board')).to eql [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 'O', nil, nil, nil, nil],
        [nil, nil, 'X', nil, nil, nil, nil]
      ]
      testboard.add_token('X', 3)
      expect(testboard.instance_variable_get('@board')).to eql [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 'O', nil, nil, nil, nil],
        [nil, nil, 'X', 'X', nil, nil, nil]
      ]
      testboard.add_token('O', 3)
      testboard.add_token('X', 3)
      testboard.add_token('O', 3)
      testboard.add_token('X', 3)
      testboard.add_token('O', 3)
      expect(testboard.instance_variable_get('@board')).to eql [
        [nil, nil, nil, 'O', nil, nil, nil],
        [nil, nil, nil, 'X', nil, nil, nil],
        [nil, nil, nil, 'O', nil, nil, nil],
        [nil, nil, nil, 'X', nil, nil, nil],
        [nil, nil, 'O', 'O', nil, nil, nil],
        [nil, nil, 'X', 'X', nil, nil, nil]
      ]
    end
  end
end
