//
//  File.swift
//  IDE Academy
//
//  Created by Mohamed Abdelhamed Ahmed on 12/4/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//

import MapKit

extension CLPlacemark{
    var compactAddress: String?{
        if let name = name {
            var result = name
            
            if let street = thoroughfare{
                result += " , \(street)"
            }
            
            if let city = locality{
                result += " , \(city)"
            }
            
            if let country = country {
                result += " , \(country)"
            }
            return result
        }
        return nil
    }
}
