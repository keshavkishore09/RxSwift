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
subject.subscribe{
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




print("\n ############--- Realy Subject---########")

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


print("\nAnother behavior relay")

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
