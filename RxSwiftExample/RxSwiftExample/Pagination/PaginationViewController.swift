//
//  PaginationViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 16.07.2022.
//

import UIKit

class PaginationViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    private var data = [String]()
    private let apiCaller = APICaller()
    public var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getData()
        handleDeepLink()
    }
    
    private func handleDeepLink() {
        if id > 0 {
            data.append(contentsOf: ["Selammmmmm Id:\(id)"])
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: PaginationTableViewCell.identifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PaginationTableViewCell.identifier)
    }
    
    // Burada apiden datayı çekiyoruz.
    private func getData() {
        apiCaller.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
               
        }
        
    }
    
    // Tableview'ı kaydırdığımızda pagination için yeni veriler yüklenirken spinner gösteriyoruz. Burada onu oluşturuyoruz.
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }

}

extension PaginationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaginationTableViewCell.identifier, for: indexPath) as! PaginationTableViewCell
        let singleData = data[indexPath.row]
        cell.setup(with: singleData)
        
        return cell
    }
    
}

extension PaginationViewController: UIScrollViewDelegate {
    
    // Scrollview delegate'ini implemente ediyoruz.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        // ScrollView'ın y pozisyonu en aşağıdaysa
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            
            guard !apiCaller.isPaginating else { return }
            
            // Tableview'ın footer'ına loading spinnerı ekle.
            self.tableView.tableFooterView = createSpinnerFooter()
            
            // Verileri çek
            apiCaller.fetchData(pagination: true) { [weak self] result in
                
                // Veriler gelince footer'ı kaldır.
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                switch result {
                case .success(let moreData):
                    
                    // Verileri listeye ekle ve tableView'ı güncelle diyoruz.
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                case .failure(_):
                    break
                }
            }
        }
    }
}
