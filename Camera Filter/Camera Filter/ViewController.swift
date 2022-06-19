//
//  ViewController.swift
//  Camera Filter
//
//  Created by Keshav Kishore on 17/06/22.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? PhotosCollectionViewController else { fatalError ("Segue Destination is not found")}
        controller.selectedPhoto.subscribe(onNext: { [weak self] photo in
            print(photo)
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
        
     }
    
    
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else {return}
        FilterService().applyFilter(to: sourceImage).subscribe(onNext: { filteredImage in
            DispatchQueue.main.async {
                self.photoImageView.image = filteredImage
            }
        }).disposed(by: disposeBag)
    }
    
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.filterButton.isHidden = false
        
    }


}

