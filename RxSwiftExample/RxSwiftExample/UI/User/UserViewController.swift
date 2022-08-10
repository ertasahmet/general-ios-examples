//
//  UserController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 9.05.2022.
//

import UIKit
import RxSwift

class UserController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    
    // Burada viewModel'i initialize ediyoruz, bunu constructor'da da alabiliriz.
    var viewModel: IUserViewModel?
    let disposeBag = DisposeBag()
    var activityView = UIActivityIndicatorView(style: .medium)
    weak var coordinator: UserCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        // İlgili metodları tanımladık.
        setUI()
        setObservables()
        getUsers()
    }
    
    // Buradaki ui'i set ediyoruz.
    func setUI() {
        handleActivityIndicator()
        setupTableView()
        
        let user = User(id: 1, name: "Ahmet")
        // Giriş ypaılan kullanıcıyı bu şekilde kaydettik.
        UserDefaultsManager.shared.signedInUser = user
    
        // Bool değişkeni için bu şekilde yaptık.
        UserDefaultsManager.shared.switchIsOn = true
        
        KeychainManager.shared.setUser(user)
        
        let keychainUser = KeychainManager.shared.getUser()
        print("\(keychainUser?.id) - \(keychainUser?.name)")
    }
    
    // Burada subscribe olduğumuz metodları ekledik.
    func setObservables() {
        subscribeToLoading()
        subscribeToResponse()
        subscribeToUserSelection()
        bindToHiddenTable()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    // Error değişkeni değiştiğinde burası çalışacak ve error view'ı göstericek, tableView'ı gizleyecek.
    func bindToHiddenTable() {
        viewModel?.isErrorObservable
            .map({ isTableHidden in return !isTableHidden})
            .bind(to: self.errorView.rx.isHidden).disposed(by: disposeBag)
    }
    
    // Burada loading'e subscribe olduk ve indicator gösteriyoruz.
    func subscribeToLoading() {
        viewModel?.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.activityView.isHidden = false
                self.activityView.startAnimating()
            } else {
                self.activityView.isHidden = true
            }
        }).disposed(by: disposeBag)
    }
    
    // Burada userList'e subscribe olduk ve liste geldiğinde direkt olarak tableView'a basıyoruz.
    func subscribeToResponse() {
        self.viewModel?.usersModelObservable
            .bind(to: self.tableView
                .rx
                .items(cellIdentifier: "userCell",
                       cellType: UserCell.self)) { [weak self] row, item, cell in
                cell.lblUserName.text = item.name
        }
        .disposed(by: disposeBag)
    }
    
    // TableView'dan bir item seçildiğinde de ona göre işlem yapıyoruz.
    func subscribeToUserSelection() {
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(User.self))
            .bind { [weak self] selectedIndex, item in
                print(selectedIndex, item.name)
        }
        .disposed(by: disposeBag)
    }
    
    // ViewModel'deki getUsers metodunu çağırıyoruz.
    func getUsers() {
        viewModel?.getUsers()
    }

    func handleActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
    
}
