//
//  SampleViewController.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.05.2022.
//

import UIKit

class SampleViewController: UIViewController {

    // Bu şekilde view, label gibi componentlar oluşturup parametrelerini ekleyebiliyoruz.
    let baseView : UIView = {
        let myView = UIView()
        myView.backgroundColor = .blue
        myView.layer.cornerRadius = 5
        myView.clipsToBounds = true
      //  myView.frame.size = .init(width: 100, height: 50)
        return myView
    }()
    
    lazy var loginView : UIView = {
        let myView = UIView()
        myView.backgroundColor = .green
        return myView
    }()
    
    lazy var login1View : UIView = {
        let myView = UIView()
        myView.backgroundColor = .black
        return myView
    }()
    
    lazy var login2View : UIView = {
        let myView = UIView()
        myView.backgroundColor = .orange
        return myView
    }()
    
    // Veya bu şekilde önce ekliyoruz daha sonra configure edebiliyoruz.
    lazy var lblTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Genel view'ları en üstteki sayfanın view'ına ekliyoruz.
        view.backgroundColor = .white
        view.addSubview(baseView)
        view.addSubview(lblTitle)
        view.addSubview(loginView)
        
        // Bir view'ın içine de bu şekilde birşeyler ekliyoruz.
        loginView.addSubview(login1View)
        loginView.addSubview(login2View)
        
        // Bu şekilde center diyerek center yapıyoruz. ve frame ile width height veriyoruz.
      //  lblTitle.frame.size = .init(width: 200, height: 30)
      //  lblTitle.center = view.center
        
        createLabel()
        addViewConstraints()
        addLoginViewConstraints()
        addLoginInsideViewConstraints()
    }
    
    private func createLabel() {
        // Burada label oluşturuyoruz ve parametrelerini giriyoruz.
        // Frame ile ekranda konum ve width height oluşturabiliyoruz.
      //  lblTitle.frame = CGRect(x: 20, y: 100, width: 150, height: 60)
        lblTitle.backgroundColor = .blue
        lblTitle.text = "Ahmet"
        lblTitle.textAlignment = .center
        lblTitle.textColor = .white
        lblTitle.layer.cornerRadius = 5
        lblTitle.clipsToBounds = true
        // Cosntraintlerini oluşturmak için de metodu çağırdık.
        constraintLabel()
    }
    
    private func constraintLabel() {
        // Bu metodda da constraint listesi açıyoruz ve bu listeye constraint ekleyip toplu şekilde activate yapıyoruz.
        var constraints = [NSLayoutConstraint]()
        
        // Constraintleri aktif etmek için ilk etapta bu değeri false'a set ediyoruz.
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Top anchor ile label'ın top'ını genel sayfanın top'uan eşitledik ve 250 aşağısında ol dedik.
        constraints.append(lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250))
        
        // Yatayda center yaptık ve ortaladık.
        constraints.append(lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        
        // Label'ın height'ını 30, width'ini de 100 verdik.
        constraints.append(lblTitle.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(lblTitle.widthAnchor.constraint(equalToConstant: 100))
        
        
        // View'ı centerlamak için de bunları yapıyoruz.
      /*  constraints.append(lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(lblTitle.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(lblTitle.widthAnchor.constraint(equalToConstant: 100)) */
        
        // Burda constraint listesini toplu active ediyoruz.
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        // Başka bir view oluşturduk ve label'a gölge gibi bir efekt tanımladık, güzel şekil yaptık.
        constraints.append(baseView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: -20))
        constraints.append(baseView.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: -10))
        constraints.append(baseView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(baseView.widthAnchor.constraint(equalToConstant: 100))
        
        // Burada da blur yaptık.
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
      //  blurEffectView.frame.size = .init(width: 0, height: 0)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        baseView.addSubview(blurEffectView)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLoginViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // Yukarıdan 100px margin, sağdan ve soldan 20 px margin tanımladık. Height da 40 tanımladık. Bunun içine 2 tane view ekleyeceğiz.
        constraints.append(loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100))
     //   constraints.append(loginView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(loginView.heightAnchor.constraint(equalToConstant: 40))
       
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
      //  blurEffectView.frame.size = .init(width: 0, height: 0)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        baseView.addSubview(blurEffectView)
        
        NSLayoutConstraint.activate(constraints)
       
    }
    
    private func addLoginInsideViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // 2 tane view'ın constraintleri açtık.
        login1View.translatesAutoresizingMaskIntoConstraints = false
        login2View.translatesAutoresizingMaskIntoConstraints = false
        
        // 1. view'ı sola yaslı, yükseklikte bulunduğu view'ın center'ında olan ve 30 height'ı olan olarak tanımladık. Width'i de buluduğu view'ın width'inin 0.45'i tanımladık.
        constraints.append(login1View.centerYAnchor.constraint(equalTo: loginView.centerYAnchor))
        constraints.append(login1View.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 0))
        constraints.append(login1View.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(login1View.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.45))
       
        // Bu view'ı da sağ tarafa yaslı şekilde yukarıdaki ile aynı tanımladık.
        constraints.append(login2View.centerYAnchor.constraint(equalTo: loginView.centerYAnchor))
        constraints.append(login2View.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: 0))
        constraints.append(login2View.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(login2View.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.45))
        
        NSLayoutConstraint.activate(constraints)
    }

}
