import UIKit

class LoadableImageView: UIImageView, ImageProviderDelegate {
    
    var imageProvider = SFImageProvider()
    var onImageLoaded: (() -> Void)?
    
    func load(withSize size: CGSize, completion: (() -> Void)? = nil) {
        self.onImageLoaded = completion
        imageProvider.delegate = self
        imageProvider.loadImage(withSize: size)
    }
    
    func didLoadImage(image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
        onImageLoaded?()
    }
    
    deinit {
        print("release from memory")
    }
}
