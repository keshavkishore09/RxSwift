import UIKit
import RxSwift
import RxCocoa



let observables = Observable.just(1)


// Observables of int values
let observables2 = Observable.of(1,2,3,4,5)


// Obserbavles of the entire array
let observables3 =  Observable.of([1,2,3,4,5])


// Observables of the all single elments of the array
let observables4 = Observable.from([1,2,3,4,5,6])


// Need to unwrap the element
observables4.subscribe{ event in
    // print(event)
    if let element = event.element{
        print(element)
    }
}

// Need to unwrap the element
observables3.subscribe{event in
    // print(event)
    if let element = event.element {
        print(element)
    }
}


// No need to unwrap the element
observables4.subscribe(onNext: { element in
    print(element)
})

// No need to unwrap the element
let subscription1 =  observables3.subscribe(onNext: { element in
    print(element)
})


// Dispose the subscription
subscription1.dispose()




// Use dispose bag to dispose
let disposeBag = DisposeBag()

Observable.of("A", "B", "C").subscribe {
    print($0)
}.disposed(by: disposeBag)



// Use create function to create the observable
Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("B") // B will never get called as it is written after
    return Disposables.create()
}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("Completed")}, onDisposed: {print("Disposed")}).disposed(by: disposeBag)



print("\n #######----PublishSubect---#####")

/*********/

// Publish Subject

let subject = PublishSubject<String>()

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.asObservable().subscribe {
     event in
    print(event)
}

subject.onNext("Issue 3")
subject.onNext("Issue 4")

// subject.dispose()

subject.onCompleted()
subject.onNext("Issue 5")

/*****/
    

print("\n ##############--- BehaviorSubject---######")

/******/

let behaviorSubject = BehaviorSubject(value: "Initial Value")


behaviorSubject.onNext("Last Issue")

behaviorSubject.subscribe { event in
    print("Hello")
    print(event.element)
}

behaviorSubject.onNext("Issue 1")

/*******/




print("\n ############--- Realy Subject ---########")

/*****************/
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Replay Subjuct Issue 1")
replaySubject.onNext("Replay Subject Issue 2")
replaySubject.onNext("Replay Subject Issue 3")


replaySubject.subscribe { event in
     print(event)
}


replaySubject.onNext("Replay Subject Issue 4")
replaySubject.onNext("Replay Subject Issue 5")
replaySubject.onNext("Replay Subject Issue 6")


print("[Subscription 2]")
replaySubject.subscribe {
    print($0)
}

/********************/




/******/

// It is deprecated
// let variable = Variable("Initial Value")
// variable.value = "Hello world"

// variable.asObservable().subscribe{print($0)}
/******/



print("\n ##########----Behaviour Relay----#########")


/*******/
// Alternative of variable

let behaviorRelay =  BehaviorRelay(value: "Inital Value")

behaviorRelay.asObservable().subscribe {
    print($0)
}

// behaviorRelay.value = "hello" // Value is read-only(Uncomment it to get the error)
behaviorRelay.accept("Hello World")


print("\n Another behavior relay")

let behaviorRelay2 = BehaviorRelay(value: ["Item 1"])
var value = behaviorRelay2.value

value.append("Item 2")
value.append("Item 3")
value.append("Item 4")

behaviorRelay2.accept(value)
// behaviorRelay2.accept(behaviorRelay2.value + ["Item 5"] )
behaviorRelay2.asObservable().subscribe {
    print($0)
}

/******/





print("\n########-------Filtering Operators(Ignore Element)----##########")

/*****************/


// Ignore elments subscribe function is called only at the completion of the event and not on other emiitence.


let strikesIgnoreElement = PublishSubject<String>()

strikesIgnoreElement.ignoreElements().subscribe { _ in
    print("[Subscription is called]") // Only on oncompleted
}.disposed(by: disposeBag)



strikesIgnoreElement.onNext("A")
strikesIgnoreElement.onNext("B")
strikesIgnoreElement.onNext("C")

strikesIgnoreElement.onCompleted()

/****************/




print("\n#######--Filtering Operator(Element at)-----#####")

/*******/

let strikesElementAt = PublishSubject<String>()

strikesElementAt.element(at: 2).subscribe(onNext:{print($0)}).disposed(by: disposeBag) // gets print if the 2nd index value exist

strikesElementAt.onNext("X")
strikesElementAt.onNext("Y")
strikesElementAt.onNext("Z")
strikesElementAt.onNext("A'")

/*********/




print("\n#######--Filtering Operator(FIlter)-----#####")

/*******/

Observable.of(1,2,3,4,5,6,7).filter {
    $0 % 2 == 0
}.subscribe(onNext: {print($0)}).disposed(by: disposeBag) // Only prints 2,4,6

/*********/





print("\n#######--Filtering Operator(Skip)-----#####")

/*******/

Observable.of("A", "B", "C", "D", "E", "F").skip(3).subscribe(onNext: {print($0)}).disposed(by: disposeBag) // Skips first 3 element

/*********/




print("\n#######--Filtering Operator(Skip While)-----#####")

/*******/

Observable.of(2,2,3,4,4).skip(while: { $0 % 2 == 0
}).subscribe(onNext: {print($0)}).disposed(by: disposeBag) // When first condition is met false in skip while paramater, it print all the events from there.

/*********/




print("\n#######--Filtering Operator(Skip Until)-----#####")

/*******/


let skipUntilSubject = PublishSubject<String>()
let trigger = PublishSubject<String>()


skipUntilSubject.skip(until: trigger).subscribe(onNext: {print($0)}).disposed(by: disposeBag)// Skip until trigger is not called.
skipUntilSubject.onNext("A")
skipUntilSubject.onNext("B")


trigger.onNext("B")
skipUntilSubject.onNext("C")



/*********/




print("\n#######--Filtering Operator(Take)-----#####")

/*******/

Observable.of(1,2,3,4,5,6).take(3).subscribe(onNext: {print($0)}).disposed(by: disposeBag) // First 3 elements only

/*********/



print("\n#######--Filtering Operator(Take While)-----#####")

/*******/

Observable.of(2,4,6,7,8,10).take(while: { $0 % 2 == 0
}).subscribe(onNext: {print($0)}).disposed(by: disposeBag) // Till the time condition is met and ignores all after once it is met false afterwards.

/*********/



print("\n#######--Filtering Operator(Take Until)-----#####")

/*******/


let takeUntilSubject = PublishSubject<String>()
let takeUntilTrigger = PublishSubject<String>()

takeUntilSubject.take(until: takeUntilTrigger).subscribe(onNext: {print($0)}).disposed(by: disposeBag)

takeUntilSubject.onNext("2")
takeUntilSubject.onNext("3")
takeUntilSubject.onNext("4")


takeUntilTrigger.onNext("4")
takeUntilTrigger.onNext("5")



takeUntilSubject.onNext("6")
/*********/



print("\n #####----- Transform Operator(To array)-----#####")
// Transform operator
Observable.of(1,2,3,4,5).toArray().subscribe({print($0)}).disposed(by: disposeBag)




print("\n #####----- Transform Operator(Map)-----#####")

Observable.of(2,4,6,5,7,8).map {return $0 * 2 }.subscribe(onNext: {print($0)}).disposed(by: disposeBag)



print("\n#####----- Transform Operator(Flat Map)-----#####")

struct Student {
    var score: BehaviorRelay<Int>
}


let john = Student(score: BehaviorRelay(value: 90))
let mary = Student(score: BehaviorRelay(value: 100))



let student = PublishSubject<Student>()

student.asObservable().flatMap {$0.score.asObservable()}.subscribe({print($0)}).disposed(by: disposeBag)


student.onNext(john)
john.score.accept(100)


student.onNext(mary) // No matter mary got emiited
mary.score.accept(85) // John will be still observed


john.score.accept(33)






print("\n#####----- Transform Operator(Flat Map Latest)-----#####")



struct Student1 {
    var score: BehaviorRelay<Int>
}



let john1 = Student(score: BehaviorRelay(value: 90))
let mary1 = Student(score: BehaviorRelay(value: 75))



let student1 = PublishSubject<Student>()

student1.asObservable().flatMapLatest {$0.score.asObservable()}.subscribe({print($0)}).disposed(by: disposeBag)


student1.onNext(john1) // John emitted and observed
john1.score.accept(100) // John will be observed


student1.onNext(mary1) // Mary will be emitted and observed
john1.score.accept(200) // 	This will never gets called after mary1 got emitted
mary1.score.accept(20)
mary1.score.accept(25)



