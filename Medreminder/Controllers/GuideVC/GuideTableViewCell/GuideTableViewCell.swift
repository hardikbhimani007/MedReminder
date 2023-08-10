//
//  GuideTableViewCell.swift
//  Medreminder
//
//  Created by MacOS on 02/08/2023.
//

import UIKit
import AVKit

class GuideTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImgView: UIImageView!
    @IBOutlet weak var guideLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func comminInit(guide: String, videoURL: String) {
        self.guideLbl.text = guide
        let url = URL(string: videoURL)
        self.getthumbnailFronVideoURL(url: url!) { videoImage in
            self.thumbnailImgView.image = videoImage
        }
    }
    
    func getthumbnailFronVideoURL(url: URL, completion: @escaping ((_ image: UIImage?) -> Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssestImageGenrator = AVAssetImageGenerator(asset: asset)
            avAssestImageGenrator.appliesPreferredTrackTransform = true // Generate Video image
            let thumbnailTime = CMTimeMake(value: 2, timescale: 2)
            do {
                let cgThumbnailImage = try avAssestImageGenrator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImg = UIImage(cgImage: cgThumbnailImage)
                DispatchQueue.main.async {
                    completion(thumbImg)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
