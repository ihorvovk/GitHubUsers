//
//  BaseAPIWorker.swift
//  GitHubUsers
//
//  Created by Ihor Vovk on 29.03.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation

class BaseAPIWorker {
    
    enum Error: Swift.Error {
        case general
    }
    
    func processDataTaskCompletion<T>(data: Data?, response: URLResponse?, error: Swift.Error?, dataMapper: (Data) throws -> T) -> Result<T, Swift.Error> {
        if let error = error {
            return .failure(error)
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
            do {
                let result = try dataMapper(data)
                return .success(result)
            } catch {
                return .failure(error)
            }
        } else {
            return .failure(Error.general)
        }
    }
}

extension BaseAPIWorker.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .general:
            return NSLocalizedString("Network Error", comment: "")
        }
    }
}
