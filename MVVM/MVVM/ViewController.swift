//
//  ViewController.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/16.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import UIKit


class ViewController: UIViewController,PhotoListViewDelegate {
   
    
    var dataSource:[Photo] = [Photo]()
    var coverView = PhotoListView(frame: UIScreen.main.bounds)
    
    lazy var viewModel :PhotoViewModel = {
        return PhotoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDatas()
    }
 
}

extension ViewController {
    func setupUI()  {
        coverView.delegate = self
        view.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController {
    func setDatas()  {
        viewModel.showAlertClosure = {[weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        
        viewModel.initFetch {[weak self] (success, photos, error) in
            self?.coverView.dataSource = photos
            
        }
    }
        
}

extension ViewController {
    func listViewDidSelectCell(_ listView: PhotoListView, selectIndex: IndexPath) {
        let selectModel = viewModel.getCellModel(at: selectIndex);
        print(selectModel)
        let detailVC :PhotoDetailVC = PhotoDetailVC()
        detailVC.imageUrl = selectModel.imageUrl;
        self.present(detailVC, animated: true) {
            
        }
        
    }
}



