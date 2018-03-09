//
//  ViewController.swift
//  Memory
//
//  Created by Joseph Miller on 3/4/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cardBackColor = UIColor.cyan
    lazy var game = Memory(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = [String]() // chosen emoji set to use for a game
    var emojiThemes = [[String]]() // themes of emojis to choose from for each game
    var emoji = [Int:String]() // dictionary to track emojis used in game
    var faceEmojis = ["😀","😁","😂","😃","😄","😅","😆","😇","😈","👿","😉","😊","☺️","😋","😌","😍","😎","😏","😐","😑","😒","😓","😔","😕","😖","😗","😘","😙","😚","😛","😜","😝","😞","😟","😠","😡","😢","😣","😤","😥","😦","😧","😨","😩","😪","😫","😬","😭","😮","😯","😰","😱","😲","😳","😴","😵","😶","😷","😸","😹","😺","😻","😼","😽","😾","😿","🙀"]
    var animalEmojis = ["🐀","🐁","🐭","🐹","🐂","🐃","🐄","🐮","🐅","🐆","🐯","🐇","🐰","🐈","🐱","🐎","🐴","🐏","🐑","🐐","🐓","🐔","🐤","🐣","🐥","🐦","🐧","🐘","🐪","🐫","🐗","🐖","🐷","🐽","🐕","🐩","🐶","🐺","🐻","🐨","🐼","🐵","🙈","🙉","🙊","🐒","🐉","🐲","🐊","🐍","🐢","🐸","🐋","🐳","🐬","🐙","🐟","🐠","🐡","🐚","🐌","🐛","🐜","🐝","🐞"]
    var plantEmojis = ["🌱","🌲","🌳","🌴","🌵","🌷","🌸","🌹","🌺","🌻","🌼","💐","🌾","🌿","🍀","🍁","🍂","🍃","🍄","🌰"]
    var foodEmojis = ["🍅","🍆","🌽","🍠","🍇","🍈","🍉","🍊","🍋","🍌","🍍","🍎","🍏","🍐","🍑","🍒","🍓","🍔","🍕","🍖","🍗","🍘","🍙","🍚","🍛","🍜","🍝","🍞","🍟","🍡","🍢","🍣","🍤","🍥","🍦","🍧","🍨","🍩","🍪","🍫","🍬","🍭","🍮","🍯","🍰","🍱","🍲","🍳"]

    // TODO: Choose a random theme each time a new game starts
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiThemes = [faceEmojis, animalEmojis, plantEmojis, foodEmojis]
        emojiChoices = emojiThemes[Int(arc4random_uniform(UInt32(emojiThemes.count)))]
        updateViewFromModel()
    }
    
    @IBAction func pressNewGameButton(_ sender: UIButton) {
        game.resetGame()
        emoji = [Int:String]() // empty emoji array
        emojiChoices = emojiThemes[Int(arc4random_uniform(UInt32(emojiThemes.count)))]
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            print("card number = \(cardNumber)")
            if game.chooseCard(at: cardNumber){
                print("Flipped card")
            } else {
                print("Can not select that card")
            }
            updateViewFromModel()
        } else {
            print("chosen card not in card array")
        }
    }
    
    func updateViewFromModel() {
        // Update flip count
        flipCountLabel.text = "Flips: \(game.flipCount)"
        // Look at all the cards and see if there are matches
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = UIColor.yellow
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : cardBackColor
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        print(emoji[card.identifier] ?? "?")
        return emoji[card.identifier] ?? "?"
    }
    
}

