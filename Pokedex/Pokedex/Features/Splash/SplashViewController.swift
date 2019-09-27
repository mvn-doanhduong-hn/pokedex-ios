//
//  SplashViewController.swift
//  Pokedex
//
//  Created by LTT on 8/28/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

import Reusable
import UIKit
import RxSwift


enum MyError: Error {
    case error1
}

enum AuthStatus {
    case logged
    case guest
}

class UserStatus {
    static var authorizationStatus: AuthStatus = .guest
}

enum TestRxSwiftType {
    case observable
    case publishSubject
    case behaviorSubject
    case replaySubject
    case variableSubject
    case createObservable
    case fromObservable
    case justObservable
    case neverObservable
    case emptyObservable
    case errorObservable
    case deferredObservable
    
    case transformMap
    case transformFlatMap
    case transformScan
    case transformGroupBy
    
    case filter
    case filterUsingIgnoreElements
    case filterUsingSkip
    case filterUsingTake
    case filterUsingTakeUntil
    case filterUsingDistinctUntilChanged
    case filterUsingDebounce
    case filterUsingThrottle
    
    case combineUsingStartWith
    case combineUsingConcat
    case combineUsingMerge
    case combineUsingCombineLatest
    case combineUsingZip
    case combineUsingReduce
    
    case observeOn
    case subcribeOn
    
}

class SplashViewController: UIViewController, StoryboardBased, ViewModelBased {
    var viewModel: SplashViewModel!
    
    private let disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxSwiftDemo(testType: .transformScan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            self.viewModel.onSplashComplete()
        })
    }
    
    func bindViewModel() {
        
    }
    
    // BEGIN - Test RXSwift
    
    func testRxSwiftDemo(testType: TestRxSwiftType) {
        switch testType {
        case .observable:
            testObservable()
            
        case .publishSubject:
            testPublishSubject()
        case .behaviorSubject:
            testBehaviorSubject()
        case .replaySubject:
            testReplaySubject()
        case .variableSubject:
            testVariableSubject()
            
        case .createObservable:
            testCreateObservable()
        case .fromObservable:
            testFromObservable()
        case .justObservable:
            testJustObservable()
        case .emptyObservable:
            testEmptyObservable()
        case .neverObservable:
            testNeverObservable()
        case .errorObservable:
            testErrorObservable()
        case .deferredObservable:
            testDeferredObservable()
            
        case .transformMap:
            testTransformUsingMap()
        case .transformFlatMap:
            testTransformUsingFlatMap()
        case .transformScan:
            testTransformUsingScan()
        case .transformGroupBy:
            testTransformUsingGroupBy()
            
        case .filter:
            testFilter()
        case .filterUsingThrottle:
            testFilterUsingThrottle()
        case .filterUsingDebounce:
            testFilterUsingDebounce()
        case .filterUsingDistinctUntilChanged:
            testFilterUsingDistinctUntilChanged()
        case .filterUsingSkip:
            testFilterUsingSkip()
        case .filterUsingTake:
            testFilterUsingTake()
        case .filterUsingTakeUntil:
            testFilterUsingTakeUntil()
        case .filterUsingIgnoreElements:
            testFilterUsingIgnoreElements()
            
        case .combineUsingStartWith:
            testCombineUsingStartWith()
        case .combineUsingConcat:
            testCombineUsingConcat()
        case .combineUsingMerge:
            testCombineUsingMerge()
        case .combineUsingCombineLatest:
            testCombineUsingCombineLatest()
        case .combineUsingZip:
            testCombineUsingZip()
        case .combineUsingReduce:
            testCombineUsingReduce()
        
        case .observeOn:
            testObserveOn()
        case .subcribeOn:
            testSubcribeOn()
            
        default:
            print("Can't find type!")
        }
    }
    
    func testObservable() {
        let observableA = Observable.of(1, 2, 3, 4, 5, 6)  // Creating Observable
        let observerB = observableA.asObservable()
        // Subscribe to Observable
        observerB.subscribe { event in
            print(event)
        }
    }
    
    func testPublishSubject() {
        //Khởi tạo 1 PublishSubject
        let subject = PublishSubject<String>()
        //Chuyển PublishSubject -> Observable
        let observable : Observable<String> = subject
        
        //Chưa có 1 subscribe nào -> onNext ko có tác động
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        
        //Bắt đầu subscribe
        observable
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
        
        // Khi trong hàng đợi subscribe có ít nhất 1 cái
        subject.onNext("D")
    }
    
    func testBehaviorSubject() {
        //Khởi tạo 1 BehaviorSubject
        let subject = BehaviorSubject<String>(value: "R")
        //Chuyển BehaviorSubject -> Observable
        let observable : Observable<String> = subject
        
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        
        //Bắt đầu subscribe
        observable
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("D")
    }
    
    func testReplaySubject() {
        // Định nghĩa ReplaySubject với số lần lặp lại là 2
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        
        //Bắt đầu subscribe
        subject
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
        
        subject.onNext("D")
    }
    
    func testVariableSubject() {
        let variable = Variable<String>("Z")
        
        variable.value = "A"
        variable.value = "B"
        variable.value = "C"
        
        variable.asObservable()
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
        
        variable.value = "D"
    }
    
    func createObservable<E>(_ element: E) -> Observable<E> {
        return Observable.create { observer in
            if type(of: element) == Int.self {
                observer.on(.next(element))
                observer.on(.completed)
            } else {
                observer.on(.error(MyError.error1))
            }
            
            return Disposables.create()
        }
    }
    
    func testCreateObservable() {
        createObservable("A")
            .subscribe(
                onNext: { n in
                    print(n)
                }, onError: { error in
                    print(error)
                }, onCompleted: {
                    print("Completed")
                })
            .disposed(by: disposeBag)
    }
    
    func testFromObservable() {
        let observalbe : Observable<Any> = Observable.of([1,2,3, "A"])
        observalbe
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // Output
        // 1
        // 2
        // 3
    }
    
    func testJustObservable() {
        let observable = Observable<[String]>.just(["Init string", "DE"])
        observable
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        // Output
        // next(Init string)
        // comﬁpleted
    }
    
    func testEmptyObservable() {
        let observable = Observable<String>.empty()
        observable
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        
        // Output
        // completed
    }
    
    func testNeverObservable() {
        Observable<Any>.never()
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        
        // Output
        //
    }
    
    func testErrorObservable() {
        Observable<Any>.error(MyError.error1)
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        
        // Output
        // error(error1)
    }
    
    func permissionObservable() -> Observable<AuthStatus> {
        return .just(UserStatus.authorizationStatus)
//        return Observable.deferred {
//            return .just(UserStatus.authorizationStatus)
//        }
    }
    
    func testDeferredObservable() {
        let observable = permissionObservable()
        UserStatus.authorizationStatus = .logged
        observable.subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
    }
    
    func transformUsingMap() -> Observable<String> {
        return Observable.of(1, 2, 3)
            .map { String("\($0)") }
    }
    
    func testTransformUsingMap() {
        transformUsingMap()
            .subscribe(onNext: {
                print(type(of: $0), $0)
            })
            .disposed(by: disposeBag)
    }
    
    struct Car {
        var speed: Variable<Int>
    }
    
    func testTransformUsingFlatMap() {
        let carSubject = PublishSubject<Car>()
        carSubject.asObservable()
            .flatMap { $0.speed.asObservable() }
            .subscribe(onNext: { print("speed: \($0)") }) //score: 80
            .disposed(by: disposeBag)
        
        let car = Car(speed: Variable(200))
        let car2 = Car(speed: Variable(400))
        carSubject.onNext(car)
        car.speed.value = 300
        carSubject.onNext(car2)
        car.speed.value = 350 // => đã obserser qua car2, car bị unsubscribe
        car2.speed.value = 500
        
//        Dùng flatMap
//        speed: 200
//        speed: 300
//        speed: 400
//        speed: 350
//        speed: 500
        
//        Dùng flatMapLatest => bị mất speed: 350
//        speed: 200
//        speed: 300
//        speed: 400
//        speed: 500
        
        
    }
    
    func testTransformUsingScan() {
        Observable.of(1,2,3,4,5)
            .scan(5) { seed, value in
                return seed + value
            }.subscribe(onNext:{
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func testTransformUsingGroupBy() {
        Observable.from([1, 2, 3, 4, 5, 6, 7])
            .groupBy { ($0 % 2) == 0 }
            .subscribe (onNext: { e in
                print(e)
            })
            .disposed(by: disposeBag)
    }
    
    func testFilter() {
        let disposeBag = DisposeBag()
        Observable.of(1, 10, 3, 5, 12, 13)
            .filter { integer in
                integer > 10 // lọc các số lớn hơn 10
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func testFilterUsingThrottle() {
        
    }
    
    func testFilterUsingDebounce() {
        
    }
    
    func testFilterUsingDistinctUntilChanged() {
        Observable.of(1, 2, 2, 3, 3, 3, 4, 5, 5, 6)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func testFilterUsingSkip() {
        let disposeBag = DisposeBag()
        Observable.of(11, 12, 13, 14, 15, 16)
            .skip(4)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func testFilterUsingTake() {
        let disposeBag = DisposeBag()
        Observable.of(11, 12, 13, 14, 15, 16)
            .take(1)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    func testFilterUsingTakeUntil() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        let subjectCancel = PublishSubject<String>()
        subject
            //Đợi có tín hiệu từ subjectCancel
            .takeUntil(subjectCancel) // có thể là  (self.rx.deallocated)
            .subscribe(onNext: {
                print($0) })
            .disposed(by: disposeBag)
        
        subjectCancel
            .subscribe(onNext: {
                print($0) })
            .disposed(by: disposeBag)
        
        subject.onNext("next1")
        subject.onNext("next2")
        subjectCancel.onNext("cancel")
        subject.onNext("next3")
        // next1 next2 cancel
    }
    
    func testFilterUsingIgnoreElements() {
        let strikes = PublishSubject<String>()
        
        strikes
            .ignoreElements()
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
        
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onNext("X")
        strikes.onCompleted()
    }
    
    func testCombineUsingStartWith() {
        Observable.of(2, 3)
            .startWith(1)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // 1,2,3
    }
    
    func testCombineUsingConcat() {
        Observable.of(1, 2, 3).concat(Observable.of(4, 5, 6))
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // 1 2 3 4 5 6
    }
    
    func testCombineUsingMerge() {
        Observable.merge([ Observable.of(1,2,3), Observable.of(4,5,6)])
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // 1 4 2 5 3 6
    }
    
    func testCombineUsingCombineLatest() {
        Observable.combineLatest(Observable.of(1,2,3), Observable.of(4,5,6)) { (number1,number2) -> String in
            "\(number1) - \(number2)"
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        //1 - 4
        //2 - 4
        //2 - 5
        //3 - 5
        //3 - 6
    }
    
    func testCombineUsingZip() {
        Observable.zip(Observable.of(1,2,3), Observable.of(4,5,6,7)) { (number1,number2) -> String in
            "\(number1) - \(number2)"
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // 1 - 4
        // 2 - 5
        // 3 - 6
    }
    
    func testCombineUsingReduce() {
        //  Cộng dồn các số với giá trị bắt đầu = 0
        let source = Observable.of(1, 2, 3, 4, 5)
        let observable = source.reduce(0, accumulator: { $0 + $1 })
        observable
            .subscribe(onNext: { value in
                print(value) // 15
            })
            .disposed(by: disposeBag)
    }
    
    func testObserveOn() {
        Observable.of(1, 2, 3, 4, 5)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (data) in
                //Update UI on Main Thread
                print(data)
            })
            .disposed(by: disposeBag)
    }
    
    func testSubcribeOn() {
        // Scheduler
        let bgScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        Observable.of(1, 2, 3, 4, 5)
            .subscribeOn(bgScheduler)
            .map { n in
                n * 2
               // print("This is performed on the background scheduler")
            }
            .observeOn(MainScheduler.instance)
            .map { n in
                n * 10
               // print("This is performed on the main scheduler")
            }
            .subscribe(onNext: { data in
                print(data)
            })
            .disposed(by: disposeBag)
    }
    
}
