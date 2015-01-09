//
//  GameBoard.swift
//  Tic-Tac-Toe
//
//  Created by Ben Wagle on 1/6/15.
//  Copyright (c) 2015 Wagle's Bagels. All rights reserved.
//

import Foundation


class GameBoard {
    
    var board:[String]
    var possible_moves:[Int]
    var player_turn:String
    var move_count:Int
    var previous_player:String = "x"
    
    init(board:[String]=["", "", "", "", "", "", "", "", ""], possible_moves:[Int]=[0,1,2,3,4,5,6,7,8], player_turn:String = "o", move_count:Int=0)
    {
        self.board = board
        self.possible_moves = possible_moves
        self.player_turn = player_turn
        self.move_count = move_count
    }
    
    var win_cases = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    func check_win() ->Bool
    {
      for combo in win_cases
      {
        if (board[combo[0]] != "") && (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]])
        {
          return true
        }
      }
      return false
    }
    
    func updateBoard(move:Int)
    {
        move_count++
        board[move] = getPlayer()
        //print("\(move_count)\(getPlayer())\(move)\n")
        var move_position = find(possible_moves, move)!
        possible_moves.removeAtIndex(move_position)
        previous_player = getPlayer()
        changeActivePlayer()
    }
    
    func changeActivePlayer()
    {
        if player_turn == "o"
        {
            player_turn = "x"
        }
        else
        {
            player_turn = "o"
        }
        
    }
    
    func getPlayer()->String
    {
        return player_turn
    }
    
    func getPreviousPlayer()->String
    {
        return previous_player
    }
    
    
}