//
//  ComputerPlayer.swift
//  Tic-Tac-Toe
//
//  Created by Ben Wagle on 1/5/15.
//  Copyright (c) 2015 Wagle's Bagels. All rights reserved.
//

import Foundation


class ComputerPlayer
{
    var team: String
    var best_move_choice = 0
    var base_score = 0
    
    init(team:String = "x" ) {
        self.team = team
    }

    func findBestMove(board:GameBoard) -> Int
    {
      /********   USED FOR RANDOM PICKING OF A MOVE **************
        var best_move = Int(arc4random_uniform(UInt32([.possible_moves.count)))
        return board.possible_moves[best_move]
      *****************************************************************/
    
        base_score = board.possible_moves.count + 1
        var bound = base_score + 1
        minMax(board, number_of_moves: 0, lower_bound: -bound, upper_bound: bound)
        return best_move_choice
    }
    
    func minMax(board:GameBoard, number_of_moves:Int, var lower_bound:Int, var upper_bound:Int) -> Int
    {
      var win = board.check_win()
      if( (win && board.getPreviousPlayer() == team) || (board.move_count == 9 && !win))
      //use previous_player to get the player that made the possible winning turn
      {
        /*
        print(board.getPlayer())
        print ("\(board.move_count)")
        print("never\n\(board.board[0...2])\n\(board.board[3...5])\n\(board.board[6...8])\n")
         */
        return base_score - number_of_moves
      }
      else if(win)
      {
        //print("here\n\(board.board[0...2])\n\(board.board[3...5])\n\(board.board[6...8])\n")
        return number_of_moves - base_score
      }
        
      var potential_moves:[Int] = []
      var scores_of_potential_moves:[Int] = []
      for move in board.possible_moves
      {
        let temp_board = GameBoard(board: board.board, possible_moves:board.possible_moves, move_count: board.move_count, player_turn:board.player_turn)
        temp_board.updateBoard(move) //this makes temp_board's team incorrect for checking win
        var score = minMax(temp_board, number_of_moves: number_of_moves+1, lower_bound: lower_bound, upper_bound: upper_bound)
        if team == board.getPlayer() //use board player because board is still the correct team
        // trying to maximize the score
        {
            potential_moves.append(move)
            scores_of_potential_moves.append(score)
            if score > lower_bound
            {
              lower_bound = score
            }
        }
        else
        //trying to minimize the score
        {
            if score < upper_bound
            {
              upper_bound = score
            }
        }
        
        if upper_bound < lower_bound
        {
            break
        }
      }
        
       //print("after \(temp_board.getPlayer())")
      
      //print("\(potential_moves)\n")
      //print("\(scores_of_potential_moves)\n\n")
        
      if team != board.getPlayer()
      {
        return upper_bound
      }
      var best_score = scores_of_potential_moves.reduce(Int.min, { max($0, $1) })
      var best_score_index = find(scores_of_potential_moves, best_score)!
        
      best_move_choice = potential_moves[best_score_index]
 
      return lower_bound
        
    }
    
    func makeMove(board:GameBoard) -> Int
    {
        var move = findBestMove(board)
        return move
    }
    
    
    
}