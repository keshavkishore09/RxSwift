import UIKit
import RxSwift



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


/*********/

// Publish Subject

let subject = PublishSubject<String>()

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.subscribe{
     event in
    print(event)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

// subject.dispose()

subject.onCompleted()
subject.onNext("Issue 4")

/*****/
    

