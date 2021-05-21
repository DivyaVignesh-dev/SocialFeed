//
//  SocialFeedTableViewCell.swift
//  SocialFeed
//
//  Created by Divya on 20/05/21.
//  Copyright © 2021 Divya. All rights reserved.
//

import UIKit
import Lightbox

class SocialFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var modelsocialFeed : SocialFeed?
    {
        didSet
        {
            updateData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "SocialFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SocialFeedCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func updateData()
    {
        lblTitle.text = modelsocialFeed?.title
        if (modelsocialFeed?.media.count)! > 0
        {
            collectionView.isHidden = false
            collectionView.dataSource = self
        }
        else{
            collectionView.isHidden = true
        }
    }
    
    func getLightBoxImages() -> [LightboxImage]
    {
       var lightboxImages = [LightboxImage]()
        for media in modelsocialFeed!.media{
            let lightBox  = LightboxImage(image: media.thumbanil, text: "", videoURL: URL(string: media.url))
            lightboxImages.append(lightBox)
        }
        return lightboxImages
       
    }
    
}

extension SocialFeedTableViewCell : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (modelsocialFeed?.media.count) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialFeedCollectionViewCell", for: indexPath) as! SocialFeedCollectionViewCell
        cell.imgView.image = modelsocialFeed?.media[indexPath.row].thumbanil
               return cell
    }

   

    
}

extension SocialFeedTableViewCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SocialFeedTableViewCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lightController = LightboxController(images: getLightBoxImages(), startIndex: indexPath.row)
        lightController.modalPresentationStyle = .fullScreen
        UIApplication.getTopViewController()?.present(lightController, animated: true)
    }

}
