//
//  ViewController.swift
//  DynamicCollectionTask
//
//  Created by subramanyam on 26/11/18.
//  Copyright © 2018 nanda. All rights reserved.
//

import UIKit
import PINRemoteImage


class HomeViewController: UIViewController {
    
    var collectionData: CollectionData!
    var load: Bool!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        load = false
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        getJsonData(urlString: "https://jsonplaceholder.typicode.com/photos")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJsonData(urlString: String) {
        loader.isHidden = false
        guard let url = URL(string: urlString) else {
            print("Something went wrong");return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let colldata = data else {print("Data is nil"); return}
            guard let collectionResult = try? JSONDecoder().decode(CollectionData.self, from: colldata) else {
                print("Error: Couldn't decode data into Blog")
                 self.loader.isHidden = false
                return
            }
            self.collectionData = collectionResult
            self.load = true
            self.collectionView?.reloadData()
            print(collectionResult)
            self.loader.isHidden = true
        }
        dataTask.resume()
    }


}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = load ? collectionData.count : 0
        return count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.collectionTitleLbl.text = collectionData[indexPath.item].title
        cell.collectionIDLbl.text = String(describing: collectionData[indexPath.item].id)
        let url = URL(string: collectionData[indexPath.item].url)
        cell.collectionImageView.pin_setImage(from: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
}

