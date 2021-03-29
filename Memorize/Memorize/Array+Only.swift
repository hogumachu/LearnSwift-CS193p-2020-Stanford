//
//  Array+Only.swift
//  Memorize
//
//  Created by 홍성준 on 2021/03/29.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
