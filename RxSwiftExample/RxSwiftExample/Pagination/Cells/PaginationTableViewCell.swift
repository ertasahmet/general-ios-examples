//
//  PaginationTableViewCell.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 16.07.2022.
//

import UIKit

class PaginationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    static let identifier = String(describing: PaginationTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func setup(with name: String) {
        lblName.text = name
    }
    
}
