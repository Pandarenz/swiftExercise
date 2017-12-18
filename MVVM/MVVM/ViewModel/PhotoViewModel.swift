//
//  PhotoViewModel.swift
//  MVVM
//
//  Created by JiWuChao on 2017/12/17.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

import Foundation

class PhotoViewModel {
    let apiService: DataServerProtocol

    private var cellModels :[PhotoListModel] = [PhotoListModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    var isAllowSegue: Bool = false
    
    var selectedPhoto: Photo?
    
    private var photos: [Photo] = [Photo]()
    
    var numberOfCells : Int {
        return cellModels.count
    }
    var reloadTableViewClosure :(()->())?
    var showAlertClosure :(()->())?
    var updateLoadingStatus :(()->())?
    
    init(apiService:DataServerProtocol = DataServer()) {
        self.apiService = apiService
    }
    
    func initFetch(complate: @escaping (Bool, [Photo], RequestError?) -> ())  {
        self.isLoading = true
        apiService.fetchPopularPhoto {[weak self] (success, photos, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedPhoto(photos: photos)
            }
            complate(success, photos, error)
        }
    }
        
    func getCellModel(at indexPath:IndexPath) -> PhotoListModel {
        return cellModels[indexPath.row]
    }
    
    func createCellModel(photo:Photo) -> PhotoListModel {
        var descTextContainer :[String] = [String]()
        if let camera = photo.camera {
            descTextContainer.append(camera)
        }
        if let description = photo.description {
            descTextContainer.append(description)
        }
        let desc = descTextContainer.joined(separator: "-")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return PhotoListModel(titleText: photo.name, descText: desc, imageUrl: photo.image_url, dateText: dateFormatter.string(from: photo.created_at))
    }
    
    private func processFetchedPhoto (photos: [Photo]) {
        
        self.photos = photos
        var models = [PhotoListModel]()
        for photo in photos {
            models.append(createCellModel(photo: photo))
        }
        self.cellModels = models;
    }
    
    func getDatas(complate: @escaping (Bool, [Photo], RequestError?) -> ()){
        self.apiService.fetchPopularPhoto {(success, photos, error) in
            complate(success, photos, error)
        }
    }
}



extension PhotoViewModel {
    func userPressed(at indexPath:IndexPath) {
        let photo = self.photos[indexPath.row]
        if photo.for_sale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        } else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item not sale"
        }
    }
}



struct PhotoListModel {
    
    let titleText: String
    let descText: String
    let imageUrl: String
    let dateText: String
}


