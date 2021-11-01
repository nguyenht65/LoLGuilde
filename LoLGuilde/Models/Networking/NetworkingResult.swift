//
//  NetworkingResult.swift
//  LoLGuilde
//  tạo ra một xử lý biến đổi dữ liệu là Data từ API, thành các đối tượng như ta mong muốn. Thông qua JSONDecoder
//
//  Created by Bang on 28/10/2021.
//

import Foundation

// Extension của CodingUserInfoKey, sẽ dùng là userInfor khi decode. Để việc decode chính xác hơn
extension CodingUserInfoKey {
    static let contentIdentifier = CodingUserInfoKey(rawValue: "contentIdentifier")!
}

struct NetworkingResult<Content: Decodable>: Decodable {
    
    let content: Content // kieu du lieu muon chuyen doi ve
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int? = nil
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = 0
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        guard let ci = decoder.userInfo[CodingUserInfoKey.contentIdentifier],
              let contentIdentifier = ci as? String,
              let key = CodingKeys(stringValue: contentIdentifier) else {
                  throw NetworkingError.invalidDecoderConfiguration
              }
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            content = try container.decode(Content.self, forKey: key)
            print(content)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
