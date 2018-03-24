//
//  ViewController.swift
//  Memory
//
//  Created by Joseph Miller on 3/4/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cardBackColor: UIColor = UIColor.black
    var cardFrontColor: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    var cardBorderColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBOutlet var level1Buttons: [UIButton]!
    @IBOutlet var level2Buttons: [UIButton]!
    @IBOutlet var level3Buttons: [UIButton]!
    @IBOutlet var level4Buttons: [UIButton]!
    @IBOutlet var level5Buttons: [UIButton]!
    @IBOutlet var level6Buttons: [UIButton]!
    @IBOutlet var level7Buttons: [UIButton]!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var totalScoreLabel: UILabel!
    var emojiChoices = [String]() // chosen emoji set to use for a game
    var emoji = [Int:String]() // dictionary to track emojis used in game
    var cardsPerLevel: [[UIButton]] = []
    lazy var visibleCards: [UIButton] = level1Buttons
    lazy var cardPairs = visibleCards.count/2
    var memoryGame: Game = Game()
    var maxLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level2Buttons.append(contentsOf: level1Buttons)
        level3Buttons.append(contentsOf: level2Buttons)
        level4Buttons.append(contentsOf: level3Buttons)
        level5Buttons.append(contentsOf: level4Buttons)
        level6Buttons.append(contentsOf: level5Buttons)
        level7Buttons.append(contentsOf: level6Buttons)
        cardsPerLevel.append(level1Buttons)
        cardsPerLevel.append(level2Buttons)
        //cardsPerLevel.append(level3Buttons)
        cardsPerLevel.append(level4Buttons)
        cardsPerLevel.append(level5Buttons)
        cardsPerLevel.append(level6Buttons)
        cardsPerLevel.append(level7Buttons)
        maxLevel = cardsPerLevel.count
        setUpLevel(level: 0)
    }
    
    func setUpLevel(level: Int) {
        visibleCards = (level < maxLevel) ? cardsPerLevel[level] : cardsPerLevel[maxLevel-1]
        cardPairs = visibleCards.count/2
        memoryGame.setUpCards(numberOfPairsOfCards: cardPairs)
        emoji = [Int:String]() // empty seen emoji array
        hideExtraCards()
        if level >= maxLevel {
            setRandomTheme()
        } else {
            setLevelTheme()
        }
    }
    
    func hideExtraCards() {
        for card in cardButtons {
            if visibleCards.contains(card) {
               card.isHidden = false
            } else {
                card.isHidden = true
            }
        }
    }
  
    func setLevelTheme() {
        let newTheme = Theme.themeFor(level: memoryGame.level)
        setTheme(newTheme)
        hideExtraCards()
        updateViewFromModel()
    }
    
    func setRandomTheme() {
        let newTheme = Theme.randomTheme()
        setTheme(newTheme)
        updateViewFromModel()
    }
    
    func setTheme(_ newTheme: Theme) {
        switch newTheme {
        case .animals:
            emojiChoices = animalEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .animalHeads:
            emojiChoices = animalHeads
            gameBoard.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case .catHeads:
            emojiChoices = catHeads
            gameBoard.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case .plants:
            emojiChoices = plantEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .food:
            emojiChoices = foodEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        default:
            emojiChoices = faceEmojis
            gameBoard.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cardFrontColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cardBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    @IBAction func pressNewGameButton(_ sender: UIButton) {
        memoryGame.resetLevel()
        setUpLevel(level: memoryGame.level)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = visibleCards.index(of: sender) {
            print("card number = \(cardNumber)")
            if memoryGame.game.chooseCard(at: cardNumber){
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
        // Update Title
        levelLabel.text = "Level \(memoryGame.level+1)"
        // Update score
        scoreLabel.text = "Level Score: \(memoryGame.game.score)"
        totalScoreLabel.text = "Score: \(memoryGame.totalScore)"
        // Look at all the cards and see if there are matches
        for index in visibleCards.indices {
            let button = visibleCards[index]
            let card = memoryGame.game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = cardFrontColor
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = cardBackColor
            }
            // rounded corners
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            // boarders
            button.layer.borderColor = cardBorderColor.cgColor
            button.layer.borderWidth = 2
            // Hide matched cards
            if card.isMatched {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = UIColor.clear
                button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            }
        }
        // Change the button text if the board is cleared
        if memoryGame.game.boardCleared {
            newGameButton.titleLabel?.text = "Next Level"
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

