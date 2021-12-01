//
//  FileHelper.swift
//  LoLGuilde
//
//  Created by Bang on 31/10/2021.
//

import Foundation

class FileHelper {

    // create path
    static func cachedFileURL(_ fileName: String) -> URL {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .allDomainsMask)
            .first!
            .appendingPathComponent(fileName)
    }

}
