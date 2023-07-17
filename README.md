# Study_Swift_Angela
# 공부한 것들 

## Clima
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/28e91929-dbee-48b6-abcb-6df4275c9ae8" width="25%" height="25%">

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
- API_Key 처리하기
    - .plist파일 생성
        - 원하는 이름의 Key값과 키를 Value에 넣어준다
    - 코드 입력
        
        ```swift
        extension Bundle {
            
            var apiKey: String {
                // forResource에다 plist 파일 이름을 입력해주세요.
                guard let filePath = Bundle.main.path(forResource: "plist이름", ofType: "plist"),
                      let plistDict = NSDictionary(contentsOfFile: filePath) else {
                    fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
                }
                
                // plist 안쪽에 사용할 Key값을 입력해주세요.
                guard let value = plistDict.object(forKey: "API_KEY") as? String else {
                    fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
                }
                
                // 또는 키 값을 통해 직접적으로 불러줄 수도 있어요.
                // guard let value = plistDict["API_KEY"] as? String else {
                //     fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
                // }
                
                return value
            }
        }
        ```
        
        - 왜 Bundle 익스텐션으로 생성하는가
            
            **NSBundle이란**
            
            `Bundle`에 포함된 코드와 리소스에 대한 표현
            
            `NSBundle`은 `ObjectiveC`를 통해 만들어진 Foundation Class이며
            
            `Bundle` 디렉터리 안에 포함된 리소스에 쉽게 접근할 수 있도록 제공되는 객체입니다.
            
            **Bundle.main이란**
            
            앱 실행 시 기본적으로 main bundle이 생성이 됩니다.
            
            main bundle == `Bundle.main`
            
            main bundle은 현재 앱이 실행중일 때 앱의 Bundle Directory에 대한 리소스에 접근할 수 있게 도와주는 놈.
            
            앱 실행시 `plist`는 메모리에 올라간 상태입니다.
            
            그러므로 `path`로 접근하면 `plist`의 파일의 리소스(값)를 사용할 수 있는거죠.
            
            즉, `Bundle`로 `plist`에 접근이 가능하므로 `Bundle` 익스텐션을 사용!
            
    - 코드 사용
        
        ```swift
        let appKey = Bundle.main.apiKey
        ```
        
    - gitignore로 plist 숨기기
        - 적용할 폴더 접근 후 `touch .gitignore`를 통해 `gitignore`를 생성해 줍니다.
        - gitignore 파일 안에 해당 파일 이름 적용
    
    [[iOS/Swift] plist의 값 얻는 방법 및 Github에서 중요한 정보 숨기는 방법(API Key, Bundle, gitignore)](https://ios-daniel-yang.tistory.com/56)


## Tipsy 
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/c921dcd2-c254-415d-82ea-beb01789c656" width="25%" height="25%">

- textField에 입력후 다른 곳을 눌렀을 때 키보드가 내려가도록 적용해봄
```swift
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    } 
```
- 근데 키보드가 좀 느리게 작동한다. 왜지??



## BMI Calculator
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/a636568c-fe2b-41fe-b93f-ef3a14a74810" width="25%" height="25%">

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


## Destini
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/dbed2d4e-7f51-47b2-bbf2-899143c20c99" width="25%" height="25%">


## Quizzler
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/be5c9167-d836-4fc0-b4bc-475a105b85ad" width="25%" height="25%">

- Structure
- MVC Pattern
- Functions with Outputs and Return Types
- Immutability


## EggTimer
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/52e2a8e2-23f9-4113-a861-e8b452631edb" width="25%" height="25%">

- If-Else / Switch
- Optionals
- Dictionary


## Xylophone
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/22539b6e-04db-48ab-aace-8c307557bace" width="25%" height="25%">

- Study Functions and Scope
