//
//  Constellation.swift
//  Jikan
//
//  Created by CHI on 2021/1/15.
//

import Foundation

enum Constellation: Int {
    case waterBearer = 1
    case fishes = 2
    case ram = 3
    case bull = 4
    case twins = 5
    case crab = 6
    case lion = 7
    case virgin = 8
    case scales = 9
    case scorpion = 10
    case archer = 11
    case goat = 12
    
    static func of(dateCode: Int) -> Constellation {
        switch dateCode {
        case 120...218:
            return .waterBearer
        case 219...320:
            return .fishes
        case 321...419:
            return .ram
        case 420...520:
            return .bull
        case 521...621:
            return twins
        case 622...722:
            return .crab
        case 723...822:
            return .lion
        case 823...922:
            return .virgin
        case 923...1023:
            return .scales
        case 1024...1122:
            return .scorpion
        case 1123...1221:
            return .archer
        default:
            return .goat
        }
    }
}
