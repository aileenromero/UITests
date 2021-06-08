//
//  ModelMapper.swift
//  App
//
//  Created by Glenn Emmanuel Solo on 10/01/2019.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation

class ModelMapper {
    
    /// Maps/Parses data to passed Generic Decodable type
    ///
    /// - parameters:
    ///     - data: JSON in data format
    /// - returns: Returns a generic decodable model if parsing is success, otherwise nil.
    class func dataToModel<T: Decodable>(data: Data) -> T? {
        do {
            let genericModel = try JSONDecoder().decode(T.self, from: data)
            return genericModel
        } catch let jsonErr {
            print(jsonErr)
            os_log_error(jsonErr)
            return nil
        }
    }
    
    /// Maps/Parses data to Generic Decodable List type
    /// - parameters:
    ///     - data: JSON in data format
    /// - returns: Returns a generic decodable model list if parsing is success, otherwise nil.
    class func dataToListModel<T: Decodable>(data: Data) -> [T]? {
        do {
            let genericModelList = try JSONDecoder().decode(
                [T].self, from: data)
            return genericModelList
        } catch let jsonErr {
            print(jsonErr)
            os_log_error(jsonErr)
            return nil
        }
    }
    
}

