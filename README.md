# Study_Swift_Angela
# 공부한 것들 

## Todoey
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/ccc2e0ec-a55a-438a-8b90-fe0ecb622eb8" width="25%" height="25%">

- UserDefaults
    - Unity의 Playerpref와 비슷 하다
    - 앱의 Library → Preferences → .plist 형태로 저장 됨
    - UserDefaults는 사용자의 정보를 저장하는 싱글톤 인스턴스이다.
    - UserDefaults는 사용자 기본 설정과 같은 **단일 데이터 값**에 적합합니다.
    - 표준 유형의 데이터만 사용 가능. 사용자 지정 유형 사용 불가.
    
    ### 장점
    
    - UserDefaults는 사용하기 쉽다.
    - Thread safe하다. (동기화 적정 없이 어떤 쓰레드에서든 읽고 쓸 수 있다.)
    - UserDefault는 앱과 앱 extensions에서 공유된다.
    
    ### 단점
    
    - 동일한 키의 값을 쉽게 재정의 할 수 있습니다 (키 충돌 가능성).
    - UserDefaults는 암호화되지 않습니다.
    - Unit Test 시 UserDefault는 잘못된 값을 일으킬 수 있습니다.
    - UserDefaults는 앱의 어느 곳에서나 전역적으로 변경 될 수 있으므로 inconsistent한 상태에서 쉽게 실행할 수 있습니다.
    - 간단한 사용자 정보를 저장 및 불러오는게 가능하지만,내부적으로 plist 파일에 저장되기 때문에 보안상 강력하지는 않다.
    
    ```swift
    import UIKit
    
    let defaults = UserDefaults.standard
    
    let dicKey = "myDictionary"
    
    defaults.set(0.24, forKey: "Volume")
    defaults.set(true, forKey: "MusicOn")
    defaults.set("Jerry", forKey: "PlayerName")
    defaults.set(Date(), forKey: "AppLastOpenedByUser")
    let array = [1, 2, 3]
    defaults.set(array, forKey: "myArray")
    let dictionary = ["name": "Jerry"]
    defaults.set(dictionary, forKey: dicKey)
    
    let volume = defaults.float(forKey: "Volume")
    let appLastOpen = defaults.object(forKey: "AppLastOpenedByUser")
    let myArray = defaults.array(forKey: "myArray") as! [Int]
    let myDic = defaults.dictionary(forKey: dicKey)
    ```
    
- NSCoder
    - 사용자 지정 유형 사용 가능.
      
    ```swift
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    func loaditems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
            
        }
    }
    ```

    

## H4X0R_News
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/6a070c9b-2926-47ea-9681-e3a5220fc5c1" width="25%" height="25%">

- 웹뷰 추가하기
    
    ```swift
    import WebKit
    import SwiftUI
    
    struct WebView: UIViewRepresentable {
        let urlString: String?
        
        func makeUIView(context: Context) -> WKWebView {
            return WKWebView()
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            if let safeString = urlString {
                if let url = URL(string: safeString) {
                    let request = URLRequest(url: url)
                    uiView.load(request)
                }
            }
        }
    }
    ```
    
- 네트워킹
    
    ```swift
    class NetworkManager: ObservableObject {
        
        @Published var posts = [Post]() //⭐️옵져버 패턴
        
        func fetchData() {
            if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let result = try decoder.decode(Results.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.posts = result.hits
                                }
                                
                            } catch {
                                print(error)
                            }
                            
                        }
                        
                    }
                }
                task.resume()
            }
        }
    }
    ```

## Dicee
<img src="https://github.com/ryan2414/ryan2414/assets/75060346/781bf801-c9f2-4151-9faf-dcef6db83e1d" width="25%" height="25%">

- 특정 변수 변경할 때
    
    @State를 변수 앞에 붙여준다. 변수가 수정되면 자동으로 사용하는 UI를 초기화 해줌 
    
    ```swift
    struct ContentView: View {
        
        @State var leftDiceNumber = 1 //⭐️⭐️⭐️⭐️⭐️
        @State var rightDiceNumber = 1 //⭐️⭐️⭐️⭐️⭐️
        
        var body: some View {
            VStack {
                ZStack {
                    Image("background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Image("diceeLogo")
                        Spacer()
                        HStack {
                            DiceView(n: leftDiceNumber) //⭐️⭐️⭐️⭐️⭐️
                            DiceView(n: rightDiceNumber) //⭐️⭐️⭐️⭐️⭐️
                        }
                        .padding(.horizontal)
                        Spacer()
                        Button {
                            self.leftDiceNumber = Int.random(in: 1...6)
                            self.rightDiceNumber = Int.random(in: 1...6)
                        } label: {
                            Text("Roll")
                                .font(.system(size: 50))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        .background(Color.red)
                        .padding(.bottom)
    
                    }
                }
            }
            
        }
    }
    ```
    

## Name Card
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/33dc21b6-4340-4351-949f-c0eb582381a6" width="25%" height="25%">

- SwiftUI
    - Font 추가 하기 
        [How to use custom fonts with SwiftUI | Sarunw](https://sarunw.com/posts/swiftui-custom-font/#register-your-font-file-with-ios)
- App Icon 추가하기
    [SwiftUI : App Icon](https://seons-dev.tistory.com/entry/SwiftUI-App-Icon)


## I Am Rich
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/ae5f8fda-4e1a-4526-9938-5343ad09acf0" width="25%" height="25%">

- 첫 SwiftUI Project


## Flash Chat
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/0be938fd-cd17-49f0-9ac0-a588f5dfbefb" width="25%" height="25%">

- Cocoapod과 Swift Package Manager를 활용한 라이브러리 추가
- FireBase를 사용한 회원가입, 로그인 기능 구현
- FireStore를 사용한 채팅 내용 서버 저장
- TableView, Xib


## ByteCoin
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/15fc0422-3ab7-4dfa-bdd4-1fc72959f185" width="25%" height="25%">



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
<img src="https://github.com/ryan2414/Study_Swift_Angela/assets/75060346/e447eca1-cfe0-46cc-93a6-006e9289730e" width="25%" height="25%">

- Study Functions and Scope
