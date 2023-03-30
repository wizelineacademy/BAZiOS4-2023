//
//  FileManagerExtension.swift
//  AVFoundationExample
//
//  Created by Benny Reyes on 29/03/23.
//

import Foundation

extension FileManager{
    
    static func getDocumentsDirectory(appendPath:String = "")-> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first?.appending(component: appendPath)
    }
    
}



