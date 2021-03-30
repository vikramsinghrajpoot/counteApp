//
//  ScoreViewModel.swift
//  testApp
//
//  Created by Vikram Rajpoot on 30/03/21.
//
///sagar.verma@bijak.in
import Foundation

protocol ScoreViewModelDelegate:class {
    func updateScore(score: Score)
    func reachedMaximum()
}

class ScoreViewModel {
    
    weak var delegate: ScoreViewModelDelegate?
    var score:Score!
    var count: Int
    var data:[Int]!
    
    init(delegate:ScoreViewModelDelegate) {
        score = Score()
        self.delegate = delegate
        count = 0
        data = [Int]()
    }
    
    func getRandom(){
       let num = Int.random(in: 1..<7)
        count = count + 1
        score.total = score.total + num
        data.append(num)
        if(count == 6){
            self.delegate?.reachedMaximum()
            count = 0
            score.max = score.total + score.max
            score.max = score.max
        }
        score.currrent = num
        score.total = score.total
        self.delegate?.updateScore(score: score)
    }
    
    func scoreCount() -> Int{
        return data.count
    }
    
    func getScoreData(index: Int) -> Int {
       return self.data[index]
    }
    
    
    func resetScore(){
        score.currrent = 0
        score.total = 0
        self.data.removeAll()
        self.delegate?.updateScore(score: score)
    }
    
}
