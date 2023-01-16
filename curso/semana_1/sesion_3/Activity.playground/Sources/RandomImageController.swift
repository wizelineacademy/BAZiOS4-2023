import UIKit

public class RandomImageController: UIViewController {
    
    private let imageSize: CGSize = .init(width: 200, height: 200)
    private var imageView: LoadableImageView? {
        didSet {
            guard let oldImageView = oldValue else { return }
            animateOut(oldImageView)
        }
    }
    
    public override func loadView() {
        self.view = UIView()
        self.view.frame = .init(origin: .zero, size: .init(width: 320, height: 480))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupReloadButton()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadImage()
    }
    
    @objc
    private func reloadImage() {
        let imageView = insertImageView()
        imageView.load(withSize: imageSize) {
            self.animateIn(imageView)
        }
        self.imageView = imageView
    }
}

extension RandomImageController {
    private func setupReloadButton() {
        let button = UIButton.systemButton(with: .init(systemName: "arrow.clockwise")!,
                                           target: self,
                                           action: #selector(reloadImage))
        view.addSubview(button)
        button.center = .init(x: view.frame.width/2, y: view.frame.height - 50)
    }
    
    private func insertImageView() -> LoadableImageView {
        let imageView = LoadableImageView()
        view.addSubview(imageView)
        imageView.frame = .init(origin: .zero, size: imageSize)
        imageView.center = view.center
        
        imageView.transform = CGAffineTransform.identity
            .translatedBy(x: 200, y: -120)
            .rotated(by: -CGFloat.pi / 6)
    
        return imageView
    }
    
    private func animateIn(_ view: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.6, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
    
    private func animateOut(_ view: UIView) {
        UIView.animate(withDuration: 1, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
        })
    }
}
