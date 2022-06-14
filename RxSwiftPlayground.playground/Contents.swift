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
observables3.subscribe(onNext: { element in
    print(element)
})
