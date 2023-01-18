//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

let remoteImageProvider = RemoteImageProvider()
let symbolImageProvider = SFImageProvider()
let avatarImageProvider = AvatarImageProvider()

var viewController = RandomImageController()

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = viewController
