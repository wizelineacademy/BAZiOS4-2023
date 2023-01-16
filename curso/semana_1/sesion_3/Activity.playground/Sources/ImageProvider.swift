import UIKit

public protocol ImageProviderDelegate: AnyObject {
    func didLoadImage(image: UIImage)
}

public protocol ImageProvider: AnyObject {
    var delegate: ImageProviderDelegate? { get set }
    func loadImage(withSize size: CGSize)
}

public class RemoteImageProvider: ImageProvider {
    
    public var delegate: ImageProviderDelegate?
    
    public init() { }
    
    public func loadImage(withSize size: CGSize) {
        guard let url = URL(string: "https://picsum.photos/\(Int(size.width))/\(Int(size.height))") else { return }
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            self.delegate?.didLoadImage(image: image)
        }.resume()
    }
}

public class SFImageProvider: ImageProvider {
    
    public var delegate: ImageProviderDelegate?
    
    public init() { }
    
    let sfSymbols: [String] = {
        guard
            let file = Bundle.main.url(forResource: "sfsymbols", withExtension: "json"),
            let data = try? Data(contentsOf: file),
            let array = try? JSONDecoder().decode([String].self, from: data) else { return [] }
        return array
    }()
    
    public func loadImage(withSize size: CGSize) {
        guard let sfName = sfSymbols.randomElement(),
              let image = UIImage(systemName: sfName) else { return }
        self.delegate?.didLoadImage(image: image)
    }
}

public class AvatarImageProvider: ImageProvider {
    
    public var delegate: ImageProviderDelegate?
    
    public init() { }
    
    let avatarSeeds: [String] = {
        guard
            let file = Bundle.main.url(forResource: "avatarseeds", withExtension: "json"),
            let data = try? Data(contentsOf: file),
            let array = try? JSONDecoder().decode([String].self, from: data) else { return [] }
        return array
    }()
    
    public func loadImage(withSize size: CGSize) {
        guard let avatarSeed = avatarSeeds.randomElement(),
              let url = URL(string: "https://api.dicebear.com/5.x/adventurer/png?seed=\(avatarSeed)") else { return }
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            self.delegate?.didLoadImage(image: image)
        }.resume()
    }
}

