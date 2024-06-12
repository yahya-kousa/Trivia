//
//  PlayViewController.swift
//  Trivia
//
//  Created by Kousa, Yahya on 12/19/23.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    var selectedCategory = ""
    var selectedNumberOfQuestions = 0
    var correctAnswerNumber = 0
    var numberOfCorrectAnswers = 0
    var numberOfQuestionsAnswered = 0
    var progress: Float = 0
    var progressIntervals: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    func viewLoadSetup()
    {
        for i in 0...3
        {
            answerButtons[i].backgroundColor = .systemBlue
        }
        
        progressIntervals = 1.0 / Float(selectedNumberOfQuestions)
        
        tabBarController?.viewControllers![0].tabBarItem.isEnabled = false

        loadQuestion()
        
        tabBarItem.isEnabled = false

    }

    
    
    func loadQuestion()
    {
        let problem = Trivia.getQuestions()[self.selectedCategory]?.randomElement()
        let question = problem?.question
        questionLabel.text = question
        let correct = (problem?.c)!
        let incorrect = problem?.i
        var answers = incorrect
        answers?.append(correct)
        answers?.shuffle()
        for i in 0...3
        {
            if answers![i] == correct
            {
                correctAnswerNumber = i
            }
            answerButtons[i].setTitle(answers![i], for: .normal)
        }
        
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == correctAnswerNumber
        {
            UIView.animate(withDuration: 1.0, animations: { self.answerButtons[sender.tag].backgroundColor = .green; self.answerButtons[0].isEnabled = false; self.answerButtons[1].isEnabled = false; self.answerButtons[2].isEnabled = false; self.answerButtons[3].isEnabled = false}, completion: { _ in self.answerButtons[sender.tag].backgroundColor = .systemBlue; self.numberOfCorrectAnswers += 1 ; self.numberOfQuestionsAnswered += 1 ; if (self.numberOfQuestionsAnswered < self.selectedNumberOfQuestions)
                {
                self.progress += self.progressIntervals
                self.progressBar.setProgress(self.progress, animated: true)
                self.loadQuestion()
            }
                else
                {
                    self.performSegue(withIdentifier: "popup", sender: nil)
                }; self.answerButtons[0].isEnabled = true; self.answerButtons[1].isEnabled = true; self.answerButtons[2].isEnabled = true
                ; self.answerButtons[3].isEnabled = true})
        }
        else
        {
            UIView.animate(withDuration: 1.0, animations: { self.answerButtons[sender.tag].backgroundColor = .red; self.answerButtons[self.correctAnswerNumber].backgroundColor = .green; self.answerButtons[0].isEnabled = false; self.answerButtons[1].isEnabled = false; self.answerButtons[2].isEnabled = false; self.answerButtons[3].isEnabled = false
            }, completion: { _ in self.answerButtons[sender.tag].backgroundColor = .systemBlue; self.answerButtons[self.correctAnswerNumber].backgroundColor = .systemBlue; self.numberOfQuestionsAnswered += 1 ; if (self.numberOfQuestionsAnswered < self.selectedNumberOfQuestions)
                {
                self.progress += self.progressIntervals
                self.progressBar.setProgress(self.progress, animated: true)
                self.loadQuestion()
            }
                else
                {
                    self.performSegue(withIdentifier: "popup", sender: nil)
                };
                self.answerButtons[0].isEnabled = true; self.answerButtons[1].isEnabled = true; self.answerButtons[2].isEnabled = true
                ; self.answerButtons[3].isEnabled = true
            
            })

            
        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let popupViewController = segue.destination as? Popup
        {
            
            popupViewController.correctNumber = numberOfCorrectAnswers
            popupViewController.totalNumber = selectedNumberOfQuestions
            for i in 0...3
            {
                answerButtons[i].setTitle("", for: .normal)
            }
            questionLabel.text = ""
            selectedCategory = ""
            selectedNumberOfQuestions = 0
            correctAnswerNumber = 0
            numberOfCorrectAnswers = 0
            numberOfQuestionsAnswered = 0
            progressBar.progress = 0
            progress = 0
            

        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
