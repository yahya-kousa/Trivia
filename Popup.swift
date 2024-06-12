//
//  Popup.swift
//  Trivia
//
//  Created by Kousa, Yahya on 1/17/24.
//

import UIKit

class Popup: UIViewController {
    
    
    @IBOutlet var labelOutlet: UILabel!
    var correctNumber = 0
    var totalNumber = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOutlet.text = "You got \(correctNumber) out of \(totalNumber)!"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwind", sender: nil)
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
