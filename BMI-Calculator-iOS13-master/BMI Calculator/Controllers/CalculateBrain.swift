//
//  CalculateBrain.swift
//  BMI Calculator
//
//  Created by 이승재 on 2023/07/14.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct CalculateBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / powf(height, 2)
       
        
        if ..<18.5 ~= bmiValue {
            print("underweight")
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else if 18.5..<24.9 ~= bmiValue {
            print("nomal weight")
            bmi = BMI(value: bmiValue, advice: "Fir as a fiddle!", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else {
            print("over weight")
            bmi = BMI(value: bmiValue, advice: "Eat less pies!.", color:  #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
            
        
        //bmi = BMI(value: bmiValue, advice: <#T##String#>, color: <#T##UIColor#>)
    }
    
    func getBMIValue() -> String {
        guard let bmi = bmi?.value else { return "0.0" }
        
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice() -> String {
        guard let advice = bmi?.advice else { return "No advice"}
        
        return advice
    }
    
    func getColor() -> UIColor {
        guard let color = bmi?.color else { return UIColor.white }
        
        return color
    }
}
