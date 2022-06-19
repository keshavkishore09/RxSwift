//
//  PhotosCollectionViewController.swift
//  Camera Filter
//
//  Created by Keshav Kishore on 18/06/22.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
    
    private let selectedPhotosubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage>{
        return selectedPhotosubject.asObservable()
    }
    private var images = [PHAsset]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {fatalError("Photo Collection view not found")}
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            guard let info  = info else {return}
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            if !isDegradedImage {
                if let image = image {
                    self?.selectedPhotosubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // access the photos
                let phAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                phAssets.enumerateObjects {(object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            
        }
        
        
    }
}
