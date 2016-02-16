//
//  Quote.swift
//  myProduct
//
//  Created by Caleb on 2/15/16.
//  Copyright © 2016 Caleb. All rights reserved.
//

import Foundation
import Mapper

struct Quote: Mappable{
    //MARK: Properties
    let quote: String
    let author: String
    let generated: Bool?
    let date: NSDate?
    let source: String?
    
    init(map: Mapper) throws {
        quote = try map.from("quote")
        author = try map.from("author")
        generated = map.optionalFrom("generated")
        date = map.optionalFrom("date")
        source = map.optionalFrom("source")
    }
}
