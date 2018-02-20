//
//  QuesnserAnswerHelper.swift
//  GetSmart
//
//  Created by Abhinay on 19/02/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import Foundation

struct QuesnserAnswerRecord
{
    let question:String!
    let answers:[String]!
    let rightAnswer:String!
    var answerProvided = QuesnserAnswerHelper.Constant.defaultQuestionTitle
}

final class QuesnserAnswerHelper
{
    static let sharedInstance = QuesnserAnswerHelper()
    
    let question1 = QuesnserAnswerRecord(question: "What is your name", answers: ["Abhinay","Arun","Arvind","Anand"], rightAnswer: "Abhinay", answerProvided:Constant.defaultQuestionTitle)
    let question2 = QuesnserAnswerRecord(question: "What is your name", answers: ["Abhinay","Arun","Arvind","Anand"], rightAnswer: "Abhinay", answerProvided:Constant.defaultQuestionTitle)
    let question3 = QuesnserAnswerRecord(question: "What is your name", answers: ["Abhinay","Arun","Arvind","Anand"], rightAnswer: "Abhinay", answerProvided:Constant.defaultQuestionTitle)
    let question4 = QuesnserAnswerRecord(question: "What is your name", answers: ["Abhinay","Arun","Arvind","Anand"], rightAnswer: "Abhinay", answerProvided:Constant.defaultQuestionTitle)
    let question5 = QuesnserAnswerRecord(question: "What is your name", answers: ["Abhinay","Arun","Arvind","Anand"], rightAnswer: "Abhinay", answerProvided:Constant.defaultQuestionTitle)
    
    var dataSource:[QuesnserAnswerRecord]!{
        get{
            return [self.question1, self.question2, self.question3, self.question4, self.question5]
        }
    }
    
    
}

extension QuesnserAnswerHelper
{
    struct Constant
    {
        static let defaultQuestionTitle = "Select option"
    }
}
