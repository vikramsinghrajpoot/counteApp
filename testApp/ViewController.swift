//
//  ViewController.swift
//  testApp
//
//  Created by Vikram Rajpoot on 30/03/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentScoreTF: UITextField!
    @IBOutlet weak var totalScoreTF: UITextField!
    @IBOutlet weak var hightScoreTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clickBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    var viewModel:ScoreViewModel!
    
    override func viewDidLoad() {
        viewModel  = ScoreViewModel(delegate: self)
        super.viewDidLoad()
    }

    @IBAction func clickPress(_ sender: UIButton) {
        viewModel.getRandom()
    }
    
    @IBAction func resetPress(_ sender: UIButton) {
        clickBtn.isEnabled = true
        viewModel.resetScore()
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.scoreCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")
        let score = viewModel.getScoreData(index: indexPath.row)
        cell?.textLabel?.text = "Curret Score: \(score)"
        return cell!
    }
    
    
}

extension ViewController: ScoreViewModelDelegate {
    func updateScore(score: Score) {
        currentScoreTF.text = "\(score.currrent)"
        totalScoreTF.text = "\(score.total)"
        hightScoreTF.text = "\(score.max)"
        self.tableView.reloadData()
    }
    
    func reachedMaximum() {
        clickBtn.isEnabled = false
        print("Max")
        let alert = UIAlertController(title: "Alert", message: "You have reached to max score please reset it for better experience", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
}
