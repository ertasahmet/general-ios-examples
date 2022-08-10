//
//  PhotoPickerViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 20.07.2022.
//

import UIKit
import Photos
import PhotosUI

class PhotoPickerViewController: UIViewController, PHPickerViewControllerDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  Storyboarded {
    
    var images = [UIImage]()
    let picker = UIImagePickerController()
    
    // Collection view oluşturduk.
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.register(MyCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        title = "New Photo Picker"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.frame = view.bounds
    }
    
    // Foto ekle butonuna bastığımızda picker'ı çağırıyoruz.
    @objc private func didTapAdd() {
        
        // Burada 2 tür picker var. UIImagePickerController eski olan ama iyi çalışan. PHPicker yeni olan fakat bugları var. Burada ikisinin de kullanımını görüyoruz.
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 2
        config.filter = .images
        
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        
        present(picker, animated: true)
        //present(vc, animated: true)
    }
    
    // UIImagePicker dan foto seçildiğinde burası çalışıyor ve image'ı alabiliyoruz.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        print(image)
        self.images.append(image)
        self.collectionView.reloadData()
    }
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // Burada phpicker için fotoya ulaşıyoruz. Burası sırayla çalışmadığı için dispatchGroup ile group oluşturduk.
        let group = DispatchGroup()
        
        // Seçtiğimiz fotolar geldiğinde
        results.forEach { result in
            
            // Group başladı diyoruz.
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                
                // Defer keywordu bir metod içinde işlemler bittiğinde en son çalışır. Yani Aşağıda image'ı alıyor ve listeye ekliyor, herşeyi yapıyor. En son burada defer içinde yazılan şeyi çalıştırıyor ve group işlemi bitiyor.
                defer {
                    group.leave()
                }
                
                guard let image = reading as? UIImage, error == nil else { return }
                print(image)
                self?.images.append(image)
               
            }
        }
        
        // Group işlemi bittiğinde group notify ile bilgilendiriliyor. Biz de burada collectionView'ı reload ediyoruz.
        group.notify(queue: .main) {
            print(self.images.count)
            self.collectionView.reloadData()
        }
    }
    
   
    // Buralarda collectionView'ı initialize ediyoruz.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCollectionCell else {fatalError()}
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }

}
