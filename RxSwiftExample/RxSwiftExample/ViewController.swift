//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 5.05.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController, Storyboarded {
    
    // Burada coordinator instance'i alıyoruz. Yukarıda da storyboarded protocolunu implemente ettik ki bu vc'nin instance'ını storyboard'dan türetebilelim. LoginViewController.instantiate() deyince otomatik türeyecek.
    weak var coordinator: AppCoordinator?
    
    let tableViewItemsSectioned = BehaviorRelay.init(value: [
        SectionModel(header: "Main", items: [Food.init(name: "Hamburger", image: "hamburger", type: "main"),
                                             Food.init(name: "Pizza", image: "pizza", type: "main"),
                                             Food.init(name: "Spaghetti", image: "spaghetti", type: "main")]),
        
        SectionModel(header: "Desserts", items: [Food.init(name: "Pizza", image: "pizza", type: "dessert"),
                                             Food.init(name: "Spaghetti", image: "spaghetti", type: "dessert")])])
    
    // DisposeBag memory management içindir. Her yaptığımız subscribe ve bind işlemi için memory'i yönetir.
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Önce cell'leri tableView'a register ettik.
        tableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "abcCell")
        
        // Daha sonra bir RxDataSource oluşturduk ve sectionModel tipinde olduğunu belirttik. Closure içine dataSource, tableView, indexPath ve item alıyor.
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel> (configureCell: { ds, tv, ip, item in
            print(ds.sectionModels)
            
            // Biz ekstra olarak gelen her item'ın tipine bakıyoruz ona göre tableView'a cell basıyoruz.
            if item.type == "dessert" {
                let cell: ItemCell = tv.dequeueReusableCell(withIdentifier: "abcCell") as! ItemCell
                cell.lblName.text = item.name
                return cell
            } else {
                let cell: MyCell = tv.dequeueReusableCell(withIdentifier: "myCell") as! MyCell
                cell.lblName.text = item.name
                cell.imgFood.image = UIImage(named: item.image)
                return cell
            }
            
            // Burada header'ını da belirtiyoruz.
        }, titleForHeaderInSection: {ds, index in
            return ds.sectionModels[index].header
        })
        
        // Normal tableView bind işlemi bu şekilde oluyor.
      /*  tableViewItemsSectioned
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)*/
        
    
        // Eğer search ile beraber yaparsak şu şekilde oluyor.

        let foodQuery = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        // Burada şöyle yapıyoruz. Aranan string'i alıyoruz, daha sonra bizim sectioned datamızı mapliyoruz, sectionModel nesnemizin itemslarından Food List'i alıp onun içinde SEARCH kısmından gelen query'i filtreleyip geriye SectionModel dönüyoruz, o da direkt tableView'a bind oluyor.
            .map( { query in
                self.tableViewItemsSectioned.value.map { sectionModel in
                    SectionModel(header: sectionModel.header,
                                 items: sectionModel.items.filter { food in
                        query.isEmpty || food.name.lowercased().contains(query.lowercased())
                    })
                }
            })

            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        // ModelSelected metodu ile tableview içinde bir item seçilmesini yönetiyoruz. Bir itemin üstüne tıklandığında burası çalışıyor. ModelSelected içine seçilen modelin tipini yazıyoruz ve subscribe oluyoruz. Closure'da bize seçilen item veriliyor. Bununla istediğimiz işlemi yapabiliyoruz.
        tableView.rx.modelSelected(Food.self)
            .debug("mytest")
            .subscribe(onNext: { foodObject in
            
            // Herhangi bir event gerçekleştiğinde de coordinator'dan onu tetikleriz ve coordinator ilgili sayfaya gider.
                self.coordinator?.goFoodDetail(image: foodObject.image)
        }).disposed(by: disposeBag)
        
        
        
        
        // Text observable bir değişken ve orEmpty diye eklememiz de arama boş iken tamamını getirmesi için. Throttle, bize kullanıcı aramadan vazgeçerse veya o sırada başka bişey yazarsa sürekli api'ye  istek atmasın diye 0.3s gecikme veriyoruz. distinctUntilChanged ise aynı verileri getirme işleminden bizi kurtarır.
     /*   let foodQuery = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        // Daha sonra map operaörü ile filter yapıyoruz. Önce query'i alıyoruz daha sonra elimizdeki observable listesindeki itemlerin name'ine göre arama yapıp filtreleme yapıyoruz. Yeni veri kümesi filtrelenmiş veriler oluyor.
            .map( { query in
                self.tableViewItems.value.filter { food in
                    query.isEmpty || food.name.lowercased().contains(query.lowercased())
                }
            })
        
        // Daha sonra bind ile normal tableView bind işlemini yapıyoruz.
            .bind(to: tableView.rx.items(cellIdentifier: "myCell", cellType: FoodCell.self)) { tableView, item, cell in
              cell.lblFood.text = item.name
              cell.imgFood.image = UIImage(named: item.image)
          }.disposed(by: disposeBag)
        */
        
       
        
      
    //    Debug metodu ile rxswift'te debug yapabiliriz.
        
        
    }

    // Bu şekilde bir observable nesne türetiyoruz. Just metodu içine istediğimiz veriyi koyabiliyoruz.
    //  let items = Observable.just(["Ahmet", "Mehmet", "Mustafa", "Orhan", "Ömer"])

    /*  let foods = Observable.just([Food.init(name: "Hamburger", image: "hamburger"),
                                 Food.init(name: "Pizza", image: "pizza"),
                                 Food.init(name: "Spaghetti", image: "spaghetti")])*/

    // Item listemizi BehaviorRelay olarak tanımlıyoruz.
  /*  let tableViewItems = BehaviorRelay.init(value: [Food.init(name: "Hamburger", image: "hamburger"),
                                   Food.init(name: "Pizza", image: "pizza"),
                                   Food.init(name: "Spaghetti", image: "spaghetti")])*/
    
    
    
    
    
    
    // Observable olan değişkenimizi tableView'a bind ediyoruz. Custom cell type'imizi ve identifier'ını belirtiyoruz. Daha sonra cell içindeki view'lara atamasını yapıyoruz.
  /*  foods.bind(to: tableView.rx.items(cellIdentifier: "myCell", cellType: FoodCell.self)) { tableView, item, cell in
        cell.lblFood.text = item.name
        cell.imgFood.image = UIImage(named: item.image)
    }.disposed(by: disposeBag)*/
    
    /*
    items.bind(to: tableView.rx.items) { (tv, row, item) -> UITableViewCell in
        let cell = tv.dequeueReusableCell(withIdentifier: "myCell", for: IndexPath.init(row: row, section: 0)) as! FeedCell
        cell.textLabel?.text = item
        return cell
        
    }.disposed(by: disposeBag)*/
    
    

}





