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
            logDataSize(data: data)
            let genericModel = try JSONDecoder().decode(T.self, from: data)
            return genericModel
        } catch let jsonErr {
            print(jsonErr)
            Console.logError(error: jsonErr, message: "Error serializing json.")
            return nil
        }
    }
    
    /// Maps/Parses data to Generic Decodable List type
    /// - parameters:
    ///     - data: JSON in data format
    /// - returns: Returns a generic decodable model list if parsing is success, otherwise nil.
    class func dataToListModel<T: Decodable>(data: Data) -> [T]? {
        do {
            logDataSize(data: data)
            let genericModelList = try JSONDecoder().decode(
                [T].self, from: data)
            return genericModelList
        } catch let jsonErr {
            print(jsonErr)
            Console.logError(error: jsonErr, message: "Error serializing json.")
            return nil
        }
    }
    
    // MARK: - Error Handling
    
    class func dataToErrorResponse(data: Data) -> ErrorResponse? {
        do {
            logDataSize(data: data)
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return errorResponse
        } catch let jsonErr {
            print(jsonErr)
            Console.logError(error: jsonErr, message: "Error serializing json.")
            return nil
        }
    }
    
    private class func logDataSize(data: Data) {
        let sizeInMB: Double = Double(data.count / 1000000)
         Console.logInfo(message: "Response Data Size (MB): \(sizeInMB)")
        // Console.logInfo(message: "Response Data Size (Bytes): \(data.count)")
    }
    
}

