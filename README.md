# Study_Swift_Angela
# 공부한 것들 

## Tipsy 
- textField에 입력후 다른 곳을 눌렀을 때 키보드가 내려가도록 적용해봄
```swift
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } 
```
- 근데 키보드가 좀 느리게 작동한다. 왜지??



## BMI Calculator
- class and Inheritance
- struct vs class
- screen Change
    - code
    - segue
    ```swift
    //Script 방식
    let secondVC = SecondViewController()
    secondVC.bmiValue = String(format: "%.1f", bmi)
    self.present(secondVC, animated: true)
    
    // Segue 방식
    self.performSegue(withIdentifier: "goToResult", sender: self)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.bmiValue = calculateBrain.getBMIValue()
            destinationVC.bmiAdive = calculateBrain.getAdvice()
            destinationVC.bmiColor = calculateBrain.getColor()
        }
    }
    ```
- Optional Binding, Chaining, Nil Coalescing Operator
    

## Quizzler
- Structure
- MVC Pattern
- Functions with Outputs and Return Types
- Immutability

## EggTimer
- If-Else / Switch
- Optionals
- Dictionary


## Xylophone
- Study Functions and Scope
