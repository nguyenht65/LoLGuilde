//
//  DeviceHelper.swift
//  LoLib
//
//  Created by Bang on 09/12/2021.
//

import Foundation
import DeviceKit

struct DeviceHelper {

    let device = Device.current

    func isSmallDevice() -> Bool {
        switch device {
        case .iPhone4, .simulator(.iPhone4):
            return true
        case .iPhone4s, .simulator(.iPhone4s):
            return true
        case .iPhone5, .simulator(.iPhone5):
            return true
        case .iPhone5c, .simulator(.iPhone5c):
            return true
        case .iPhone5s, .simulator(.iPhone5s):
            return true
        case .iPhoneSE, .simulator(.iPhoneSE):
            return true
        default:
            return false
        }
    }

    func isLargeDevice() -> Bool {
        switch device {
        case .iPhoneXSMax, .simulator(.iPhoneXSMax):
            return true
        case .iPhone11ProMax, .simulator(.iPhone11ProMax):
            return true
        case .iPhone12ProMax, .simulator(.iPhone12ProMax):
            return true
        case .iPhone13ProMax, .simulator(.iPhone13ProMax):
            return true
        default:
            return false
        }
    }
}
