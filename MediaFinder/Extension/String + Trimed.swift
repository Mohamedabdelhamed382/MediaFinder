//
//  String + Trimed.swift
//  constranints
//
//  Created by Mohamed Abdelhamed Ahmed on 12/24/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import Foundation
extension String{
    var trimmed:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
