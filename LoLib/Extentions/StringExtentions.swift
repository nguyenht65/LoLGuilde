//
//  StringExtentions.swift
//  LoLGuilde
//
//  Created by Bang on 09/11/2021.
//

import Foundation
import UIKit

extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    var htmlToString: String {
        let result = htmlToAttributedString?.string ?? ""
        return result
    }

}
