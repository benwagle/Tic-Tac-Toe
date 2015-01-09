//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Ben Wagle on 1/4/15.
//  Copyright (c) 2015 Wagle's Bagels. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resetButton: UIButton! //used for claering the game state
    @IBOutlet weak var gameStatus: UILabel! //used fro displaying result
    
    var computer:ComputerPlayer = ComputerPlayer(team:"x")
    var player_to_print: String = "o"
    var game_board = GameBoard()
    
    var win = false
    
    func gameOver(player:String)
    {
        win = game_board.check_win()
        
        if(win) //a player has won
        {
            showOver("Player \(player.capitalizedString) wins!")
        }
            
        else if game_board.move_count == 9 //tie game
        {
            showOver("Tie game!")
        }
            
    }
    
    func showOver(message:String)
    {
        UIView.animateWithDuration(0.5, animations: {
            self.gameStatus.alpha = 1
        })
        gameStatus.text = message
        resetButton.setTitle("New Game?", forState: .Normal)
    }

    
    @IBAction func newGame(sender: AnyObject) {
        game_board = GameBoard()
        gameStatus.text = ""
        win = false
        
        resetButton.setTitle(nil, forState: .Normal)
        gameStatus.alpha = 0
        
        var button:UIButton
        for var i = 0; i < 9; i++
        {
            button = view.viewWithTag(i) as UIButton
            button.setImage(nil, forState: .Normal)
        }
    }
    
    func recordMove(move:Int)
    {
        player_to_print = game_board.getPlayer()
        game_board.updateBoard(move)
    
        //update the board UI
        var button = view.viewWithTag(move) as UIButton
        var image = UIImage(named: "\(player_to_print).png")
        button.setImage(image, forState: .Normal)
    }
    
    func computerTurn()
    {
        var move = computer.makeMove(game_board)
        recordMove(move)
        gameOver(player_to_print)
    }
    
    @IBAction func spacePressed(sender: AnyObject) {
        if (game_board.board[sender.tag] == "" && !win)
        {
            var move = sender.tag
            recordMove(move)
            gameOver(player_to_print)
        }
        
        if(game_board.getPlayer() == computer.team && !win && game_board.move_count < 9)
        {
          computerTurn()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStatus.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //resetButton.center = CGPointMake(resetButton.center.x - 400, resetButton.center.y)
    }
    
}

