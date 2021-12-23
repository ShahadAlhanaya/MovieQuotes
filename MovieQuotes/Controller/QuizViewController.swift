//
//  QuizViewController.swift
//  MovieQuotes
//
//  Created by Shahad Nasser on 22/12/2021.
//

import UIKit

class QuizViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var guessTextField: RVS_AutofillTextField!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var guessButton: UIButton!
    
    var movies = [Movie]()
    var quotes = [QuizQuote]()
    var autoFillDictionary: [String] = [
        "Elf",
        "Hamilton",
        "Joker",
        "Leon The Professional",
        "Lion",
        "Mulan"]
    var currentQuote = -1
    var score = 0
    var quizOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(gesture: )))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        guessTextField.delegate = self
        guessTextField.dataSource = self
        
        
        startQuiz()
    }
    
    @objc func swipeRight(gesture: UISwipeGestureRecognizer){
        quitQuiz()
    }
    
    func startQuiz(){
        setQuotes()
        showQuote()
        
    }

    func setQuotes(){
        for movie in movies {
            for quote in movie.quotes{
                quotes.append(QuizQuote(movie: movie.title, quote: quote))
            }
        }
        quotes.shuffle()
    }
    
    func showQuote(){
        if currentQuote < quotes.count-1{
            currentQuote += 1
            quoteLabel.text = quotes[currentQuote].quote
        }else{
            print("score \(score)")
            quizOver = true
            showScore()
        }
    }
    
    func quitQuiz(){
        if(quizOver){
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "End Quiz", message: "Do you want to end quiz?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "End", style: .default, handler: {action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showScore(){
        skipButton.isHidden = true
        guessButton.isHidden = true
        scoreLabel.isHidden = true
        guessTextField.isHidden = true
        quoteLabel.text = "You Have Guessed \(score) Movies Correctly :D!"
    }

    @IBAction func skipButtonPreessed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Answer", message: "It was from \(quotes[currentQuote].movie) movie :D!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oh Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        showQuote()
    }
    
    @IBAction func selectMoviesPressed(_ sender: UIButton) {
        quitQuiz()
    }
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        if guessTextField.text == ""{
            print("empty field")
        }else{
            if guessTextField.text?.lowercased() == quotes[currentQuote].movie.lowercased(){
                score += 1
                scoreLabel.text = "Score: \(score)"
                print("correct")
            }else{
                let alert = UIAlertController(title: "Wrong Guess", message: "It was from \(quotes[currentQuote].movie) movie D:", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "I'm sad", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("wrong")
            }
            showQuote()
        }
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        
    }
    
    
}

extension QuizViewController: RVS_AutofillTextFieldDataSource {
    /* ################################################################## */
    /**
     This is an Array of structs, that are the searchable data collection for the text field.
     If this is empty, then no searches will return any results.
     */
    var textDictionary: [RVS_AutofillTextFieldDataSourceType] {
        var index = 0
        
        let ret: [RVS_AutofillTextFieldDataSourceType] = autoFillDictionary.compactMap {
            let currentStr = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            if !currentStr.isEmpty {
                defer { index += 1 }
                return RVS_AutofillTextFieldDataSourceType(value: currentStr, refCon: index)
            }
            
            return nil
        }
        
        return ret
    }
}



extension QuizViewController: RVS_AutofillTextFieldDelegate {
    /* ################################################################## */
    /**
     This is called when the user selects one of the autofill choices.
     In this app, all we do is print to the debug console.
     - parameter inAutofillTextField: The text field instance that the user affected.
     - parameter selectionWasMade: The data item, with the string and the refCon.
     */
    func autoFillTextField(_ inAutofillTextField: RVS_AutofillTextField, selectionWasMade inSelectedItem: RVS_AutofillTextFieldDataSourceType) {
    }
}
