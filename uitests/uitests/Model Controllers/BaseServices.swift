//
//  BaseServices.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation
import Alamofire

protocol BaseServices {
    
}

extension BaseServices {

    func genericNetworkRequest<T: Decodable>(urlRequest: URLRequestConvertible, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response!.statusCode
                if statusCode < 300 {
                    let generic: T? = ModelMapper.dataToModel(data: data)
                    completion(generic, nil)
                    return
                }
                if let error = ModelMapper.dataToErrorResponse(data: data) {
                    let serverError = APIError.responseStatusError(status: error.errorCode ?? "", message: error.message)
                    completion(nil, serverError)
                    return
                }
                let unknownError = APIError.responseStatusError(status: String(statusCode), message: nil)
                completion(nil, unknownError)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func genericListNetworkRequest<T: Codable>(urlRequest: URLRequestConvertible, completion: @escaping ([T]?, Error?) -> Void) {
        AF.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response!.statusCode
                if statusCode < 300 {
                    let genericList: [T]? = ModelMapper.dataToListModel(data: data)
                    completion(genericList, nil)
                    return
                }
                if let error = ModelMapper.dataToErrorResponse(data: data) {
                    let serverError = APIError.responseStatusError(status: error.errorCode ?? "", message: error.message)
                    completion(nil, serverError)
                    return
                }
                let unknownError = APIError.responseStatusError(status: String(statusCode), message: nil)
                completion(nil, unknownError)
            case .failure(let error):
                completion(nil, error)
            }

        }
    }


    func basicNetworkRequest(urlRequest: URLRequestConvertible, completion: @escaping (Error?) -> Void) {
        AF.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response!.statusCode
                if statusCode < 300 {
                    completion(nil)
                    return
                }
                if let error = ModelMapper.dataToErrorResponse(data: data) {
                    let serverError = APIError.responseStatusError(status: error.errorCode ?? "", message: error.message)
                    completion(serverError)
                    return
                }
                let unknownError = APIError.responseStatusError(status: String(statusCode), message: nil)
                completion(unknownError)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func basicNetworkRequest(urlRequest: URLRequestConvertible, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(urlRequest).responseData { (response) in
            switch response.result {
            case .success(let data):
                let statusCode = response.response!.statusCode
                if statusCode < 300 {
                    completion(data, nil)
                    return
                }
                if let error = ModelMapper.dataToErrorResponse(data: data) {
                    let serverError = APIError.responseStatusError(status: error.errorCode ?? "", message: error.message)
                    completion(nil, serverError)
                    return
                }
                let unknownError = APIError.responseStatusError(status: String(statusCode), message: nil)
                completion(nil, unknownError)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func genericNetworkRequestWithImage<T: Codable>(parameters: [String: String?], urlRequest: URLRequestConvertible, imageData: Data, imageParameterName: String, completion: @escaping (T?, Error?) -> Void) {
        AF.upload(multipartFormData: { (multipartFormData) in
            let fileName = String(Date().millisecondsSince1970)
            multipartFormData.append(imageData, withName: imageParameterName, fileName: "\(fileName).jpg", mimeType: "image/jpeg")
            for param in parameters {
                if let value = param.value {
                    multipartFormData.append(value.data(using: .utf8)!, withName: param.key)
                }
            }
        }, with: urlRequest).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                let statusCode = responseData.response!.statusCode
                if statusCode < 300 {
                    let generic: T? = ModelMapper.dataToModel(data: data)
                    completion(generic, nil)
                    return
                }
                if let error = ModelMapper.dataToErrorResponse(data: data) {
                    let serverError = APIError.responseStatusError(status: error.errorCode ?? "", message: error.message)
                    completion(nil, serverError)
                    return
                }
                let unknownError = APIError.responseStatusError(status: String(statusCode), message: nil)
                completion(nil, unknownError)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}

