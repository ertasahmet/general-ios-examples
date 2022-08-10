//
//  UserViewModel.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//

import RxSwift
import RxRelay

protocol IUserViewModel {
    func getUsers()
    var loadingBehavior: BehaviorRelay<Bool> {get set}
    var usersModelObservable: Observable<[User]> {get}
    var isErrorObservable: Observable<Bool> {get}
    var isAnyErrorObservable: Observable<Bool> {get}
}

class UserViewModel: IUserViewModel {
    
    // ViewModel'da networkManager interface'ini constructor'da alıyoruz.
 /*   private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }*/
    
 //   @Inject var networkManager: INetworkManager
    
    var networkManager: INetworkManager
    
    init(networkManager: INetworkManager) { self.networkManager = networkManager }
    
    // Loading ve error için değişkenler oluşturuyoruz ve userList için de oluşturduk. Loading ve error değişkenlerini bir baseViewModel açıp orda ortak olarak da oluşturabiliriz.
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isError = BehaviorRelay<Bool>(value: false)
    private var usersModelSubject = PublishSubject<[User]>()
    private var isAnyErrorSubject = PublishSubject<Bool>()
    
    // UserModel'i ve error değişkenini observable olarak tanımlıyoruz ve içinde yukardaki değişkeni dönüyoruz. Yani read only olucak.
    var usersModelObservable: Observable<[User]> {
        return usersModelSubject
    }
    
    var isAnyErrorObservable: Observable<Bool> {
        return isAnyErrorSubject
    }
    
    var isErrorObservable: Observable<Bool> {
        return isError.asObservable()
    }
    
    // Bu metod ile user'ları çekiyoruz.
    func getUsers() {
        // Loading'i true yapıyoruz, bu sayede VC'de buraya observe olan kodlar çalışacak ve indicator göstericez.
        loadingBehavior.accept(true)
        
        // Sonra network manager'dan metodumuzu çağırıyoruz. Result success ise onunla ilgili işlemleri yapıyoruz. Error ise hata işlemleri yapıyoruz. Buradaki error sunucudan cevap dönüp json yanlış olduğunda bile error dönüyor o json işlemini networkManager'da yapmıştık.
        networkManager.getAllUsers { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let users):
                strongSelf.usersModelSubject.onNext(users)
                strongSelf.isError.accept(false)
                strongSelf.loadingBehavior.accept(false)
                strongSelf.isAnyErrorSubject.onNext(false)
                    
            case .failure(let error):
                print(error.localizedDescription)
                self?.isError.accept(true)
                self?.loadingBehavior.accept(false)
                self?.isAnyErrorSubject.onNext(true)
            }
        }
            
    }
    
}
