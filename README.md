# Study_Swift_Angela
# 공부한 것들 

## Clima
- Location 정보 가져오기
    
```swift
import CoreLocation

class WeatherViewController: UIViewController {
    
        let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestWhenInUseAuthorization() // 권한 획득
                //info.plist의 Privacy - Location When In Use Usage Description 수정
        locationManager.requestLocation()
        //locationManager.startUpdatingLocation() // 지속적인 위치 업데이트
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude

            weatherManager.fetchWether(lat: Int(lat), lon: Int(lon))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
```
- API 키 처리하기 

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
