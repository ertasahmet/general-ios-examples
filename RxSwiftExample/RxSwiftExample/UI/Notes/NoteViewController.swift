//
//  NoteViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 20.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class NoteViewController: UIViewController, Storyboarded {

    let viewModel = NoteViewModel()
    let disposeBag = DisposeBag()
    let coreDataManager = CoreDataManager.shared
    var notes = [Note]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setUI()
        setObservables()
        viewModel.fetchNotes()
    }
    
    
    @IBAction func addNoteClicked(_ sender: Any) {
        addNote()
    }
    
    // Burada not ekliyoruz.
    func addNote() {
        var note = Note(context: coreDataManager.viewContext)
        note.id = UUID()
        note.text = "Naber genç ü"
        note.lastUpdated = Date.now
        viewModel.addNote()
    }
    
    func setUI() {
        setupTableView()
    }

    func setObservables() {
        
        // Burada viewModel'daki verilere observe oluyoruz. Notlar geldiğinde tableView'a basıyoruz.
        self.viewModel.notesModelObservable
            .bind(to: self.tableView
                .rx
                .items(cellIdentifier: "userCell",
                       cellType: UserCell.self)) { [weak self] row, item, cell in
                cell.lblUserName.text = "\(item.text!)"
                cell.lblItemDate.text = "\(item.lastUpdated!)"
        }
        .disposed(by: disposeBag)
        
        // Notlar gelince bizim notlara atıyoruz.
        self.viewModel.notesModelObservable.subscribe {[weak self] notes in
            self?.notes = notes.element!
        } .disposed(by: disposeBag)
        
        // Yeni not eklenince notları tekrar çekiyoruz.
        self.viewModel.isAddedNewObservable.subscribe { [weak self] item in
            self!.viewModel.fetchNotes()
        } .disposed(by: disposeBag)
        
    }
    
    // Tableview'ı initialize ediyoruz.
    func setupTableView() {
        
        // Burada setDelegate yaparak rx haricinde tableViewDelegate metodlarını kullanabiliyoruz.
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
        tableView.rowHeight = 100
    }
    
    // Coredata veri silme işlemi bu şekilde yapıyoruz.
    func deleteNote(_ indexPath: IndexPath) {
        viewModel.deleteNote(notes[indexPath.row])
        self.viewModel.fetchNotes()
    }
    
    // Bunlar da ekstra öylesine metodlar
    func markAsUnread(_ indexPath: IndexPath) {
        viewModel.deleteNote(notes[indexPath.row])
        self.viewModel.fetchNotes()
    }
    
    func sendArchive(_ indexPath: IndexPath) {
        viewModel.deleteNote(notes[indexPath.row])
        self.viewModel.fetchNotes()
    }

}

extension NoteViewController : UITableViewDelegate {
    
    // Bu ve alttaki yorum satırı olan metod ile swipe to delete yapabiliyoruz.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
        }
    }
    
  /*  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }*/
    
    // Eğer daha fazla swipe action eklemek istiyorsak kendimiz bu şekilde butonlar oluşturup onlara action atayabiliriz.
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let archive = UIContextualAction(style: .normal,
                                         title: "Archive") { [weak self] (action, view, completionHandler) in
                                            self?.sendArchive(indexPath)
                                            completionHandler(true)
        }
        archive.backgroundColor = .systemGreen

        // Trash action
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
                                        self?.deleteNote(indexPath)
                                        completionHandler(true)
        }
        trash.backgroundColor = .systemRed

        // Unread action
        let unread = UIContextualAction(style: .normal,
                                       title: "Unread") { [weak self] (action, view, completionHandler) in
                                        self?.markAsUnread(indexPath)
                                        completionHandler(true)
        }
        unread.backgroundColor = .systemOrange

        let configuration = UISwipeActionsConfiguration(actions: [trash, archive, unread])

        return configuration
    }
    
}
