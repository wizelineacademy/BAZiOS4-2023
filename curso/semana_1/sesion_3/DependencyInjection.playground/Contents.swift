protocol Serializer { }

struct RequestSerializer: Serializer { }

/// Dependency Injection by initialization
class DataManager {

    private let serializer: Serializer

    init(serializer: Serializer) {
        self.serializer = serializer
    }

}

// Construcción de dependencias
let serializer = RequestSerializer()

// Construcción de cliente con servicio `serializer`
let dataManager = DataManager(serializer: serializer)


import UIKit

protocol RequestManager { }

class URLRequestManager: RequestManager { }

/// Dependency Injection by property
class ViewController: UIViewController {

    var requestManager: RequestManager? {
        didSet {
            // detener request antigüos
        }
    }

}

// Construcción de cliente
let viewController = ViewController()

// Construcción e injección de servicio
viewController.requestManager = URLRequestManager()

protocol VideoProvider { }

struct LocalVideoProvider: VideoProvider { }
struct RemoteVideoProvider: VideoProvider { }

/// Dependency Injection by method
class VideoPlayer {

    func playVideo(_ name: String, provider: VideoProvider) {
        
    }
}

// Construcción de cliente
let videoPlayer = VideoPlayer()

// Construcción e injección de servicio local
videoPlayer.playVideo("intro", provider: LocalVideoProvider())

// Construcción e injección de servicio remoto
videoPlayer.playVideo("intro", provider: RemoteVideoProvider())
