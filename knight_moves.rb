class Knight
	attr_accessor :current_position, :target_position, :board, :previous_positions

	def initialize(current_position, target_position, board, previous_positions = [])
		@target_position = target_position
		@current_position = current_position
		@board = board
		@previous_positions = previous_positions
	end

	def possible_moves
	  possible = []

		up_right = [@current_position[0] + 2, @current_position[1] + 1]
		up_left = [@current_position[0] + 2, @current_position[1] - 1]
		left_up = [@current_position[0] + 1, @current_position[1] - 2]
	  left_down = [@current_position[0] - 1, @current_position[1] - 2]
	  down_left = [@current_position[0] - 2, @current_position[1] - 1]
		down_right = [@current_position[0] - 2, @current_position[1] + 1]
		right_up = [@current_position[0] + 1, @current_position[1] + 2]
		right_down = [@current_position[0] - 1, @current_position[1] + 2]
	
    possible << up_right if @board.include?(up_right)		
    possible << up_left if @board.include?(up_left)
    possible << left_up if @board.include?(left_up)
    possible << left_down if @board.include?(left_down)
    possible << down_left if @board.include?(down_left)
    possible << down_right if @board.include?(down_right)
    possible << right_up if @board.include?(right_up)
    possible << right_down if @board.include?(right_down)
    
    possible
	end
end

def knight_moves(start_position, end_position)
  if start_position[0] < 0 || start_position[0] > 7 || start_position[1] < 0 || start_position[1] > 7
    return "Please pass a valid start position (between [0,0] and [7,7]) to the method."
  elsif end_position[0] < 0 || end_position[0] > 7 || end_position[1] < 0 || end_position[1] > 7
    return "Please pass a valid end position (between [0,0] and [7,7]) to the method."
  end
  
  board = [
		[7,0], [7,1], [7,2], [7,3], [7,4], [7,5], [7,6], [7,7],
		[6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7],
		[5,0], [5,1], [5,2], [5,3], [5,4], [5,5], [5,6], [5,7],
		[4,0], [4,1], [4,2], [4,3], [4,4], [4,5], [4,6], [4,7],
		[3,0], [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7],
		[2,0], [2,1], [2,2], [2,3], [2,4], [2,5], [2,6], [2,7],
		[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7],
		[0,0], [0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7]
		]
		
	board.reject! { |space| space == start_position }	
	knights = [Knight.new(start_position, end_position, board)]
  
  next_moves = []
  result = []
  
  # went with infinite because it will always break
  while true
    knights.each do |knight|
      # create an array of all previous positions this knight has been to. this is kind of cheating, in that
      # i'm not creating a link to the previous graph "node" but am instead creating an array as i go, but it
      # saves memory and that's worth it to me
      previous_positions = []
      knight.previous_positions.each { |move| previous_positions << move }
      previous_positions << knight.current_position
      
      if knight.current_position == end_position
        puts "You made it in #{previous_positions.length} moves! Here's your path:"
        previous_positions.each { |position| puts "#{position}" }
        return
      end
      
      knight.possible_moves.each do |move|
        # remove the space from the board once a piece has already visited it, because the first found optimal route to
        # that square has already been found
        board.reject! { |space| space == move }
        next_moves << Knight.new(move, end_position, board, previous_positions)
      end
    end
    
    knights = next_moves
  end
end