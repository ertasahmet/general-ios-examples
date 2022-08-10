import RxSwift
import RxCocoa
import RxRelay

// Subscribe and Observer tipleri
/* 1- PublishSubject: Bu ifade sadece subscribe olduktan sonra gönderilen yeni elementleri dinler. Aşağıdaki örnekte subscribe olmadan önce subject 1 gönderiliyor fakat onu yazdırmayacak, subscribe olduktan sonra gönderilen 2 numaralı eventi console'a yazıyor. */
let publishSubject = PublishSubject<String>()
publishSubject.onNext("Publish Subject 1")

let ob1 = publishSubject.subscribe(onNext: { element in
    print(element)
})

publishSubject.onNext("Publish Subject 2")


/* 2- BehaviorSubject: Bu ifade sadece son gelen veriyi gönderir ve subject'i oluştururken bir default value alır. */
let behaviorSubject = BehaviorSubject<String>(value: "Behavior Element 1")
let ob2 = behaviorSubject.subscribe(onNext: { element in
    print(element)
})

/* 3- ReplaySubject: Bu ifade birsürü gelen veri içerisinden son n tanesini almamızı sağlar. Diyelim ki 3 kere bi event gönderildi biz son 2'sini handle etmek istiyoruz, bufferSize kısmına 2 yazıyoruz ve son 2si geliyor. Sadece son 1 istiyorsak 1 yazıyoruz. */
let replaySubject = ReplaySubject<Int>.create(bufferSize: 1)
replaySubject.onNext(1)
replaySubject.onNext(2)
replaySubject.onNext(3)

let ob3 = replaySubject.subscribe(onNext: { element in
    print(element)
})

/* 4- AsyncSubject: Bu ifade sadece onCompleted metodu çağırıldığında verileri gönderir ve sadece son gönderilen veriyi gönderir. Bu case'de sadece Element 2 gönderilir. */
let asyncSubject = AsyncSubject<String>()
asyncSubject.onNext("Async Sub Element 1")
asyncSubject.onNext("Async Sub Element 2")

let ob4 = asyncSubject.subscribe(onNext: { element in
    print(element)
})

asyncSubject.onCompleted()

// --------------------------------

// Publish Relay: Relay'lar ui için kullanılan observer'lardır. onCompleted ve onError metodları yoktur, sadece değer atarız ve subscribe oluruz. Subscribe olduktan sonra gönderilen eventleri dinlerler.
let pRel = PublishRelay<String>()
pRel.accept("pRel element 1")

let ob5 = pRel.subscribe(onNext: { element in
    print(element)
})

pRel.accept("pRel element 2")


// Behavior Relay: Default olarak bir value alır.
let bRel = BehaviorRelay<String>(value: "Behavior Relay Element 1")
let ob6 = bRel.subscribe(onNext: { element in
    print(element)
})

bRel.accept("Behavior Relay Element 2")
