//
//  Utilities.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation

struct Utilities {
    
    func getURL(urlString: String?) -> URL? {
        guard let string = urlString else {
            return nil
        }
        return URL(string: string)
    }

}

