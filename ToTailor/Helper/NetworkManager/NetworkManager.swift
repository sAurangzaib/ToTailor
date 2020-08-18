//
//  NetworkManager.swift
//  ToTailor
//
//  Created by Aurangzaib-invozone on 18/08/2020.
//  Copyright © 2020 Aurangzaib-invozone. All rights reserved.
//

import Foundation
import Moya

typealias APISuccess<ReturnedObject: Decodable> = (ReturnedObject?) -> ()
typealias APIFailure = (AppError) -> ()

class APIRequest {
    var cancellable: Cancellable!
    var identifier = UUID().uuidString
}


class APIManager {
    
    public var requests = [APIRequest]()
    
    static let shared = APIManager()
    private init() {}
    
    @discardableResult static func callApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type, success: @escaping APISuccess<ReturnedObject>, failure: @escaping APIFailure) -> String {
        
        let backgroundTaskHandler = BackgroundTaskHandler()
        backgroundTaskHandler.beginBackgroundTask()
        
        let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin()])
        
        let apiRequest = APIRequest()
        
        DispatchQueue.main.async {
            //        print("API_Request sending: \(apiRequest.identifier)")
            apiRequest.cancellable = provider.request(target, completion: { result in
                switch result {
                case .success(let response):
                    debugPrint("----- Json Response -----")
                    debugPrint(response.data.prettyPrintedJSONString ?? "")
                    debugPrint("-------------------------")
                    do {
                        let results = try JSONDecoder().decode(APIResponse<ReturnedObject>.self, from: response.data)
                        if results.meta.code == 200 {
                            backgroundTaskHandler.endBackgroundTask()
                            success(results.data)
                        }
                        else {
                            let apiError = AppError(description: results.error ?? String.empty)
                            backgroundTaskHandler.endBackgroundTask()
                            failure(apiError)
                        }
                    } catch {
                        let apiError = AppError(description: error.localizedDescription)
                        backgroundTaskHandler.endBackgroundTask()
                        failure(apiError)
                    }
                    break
                case .failure(let error):
                    let apiError = AppError(description: error.localizedDescription)
                    backgroundTaskHandler.endBackgroundTask()
                    failure(apiError)
                }
                shared.removeRequestFromList(apiRequest)
            })
            shared.requests.append(apiRequest)
            
        }
        
        return apiRequest.identifier
    }
    
    func removeRequestFromList(_ apiRequest: APIRequest) {
        requests = requests.filter { $0.identifier != apiRequest.identifier}
    }
    
    static func googleApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type, success: @escaping APISuccess<ReturnedObject>, failure: @escaping APIFailure) {
        let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin()])
        
        let apiRequest = APIRequest()
        apiRequest.cancellable = provider.request(target, completion: { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(ReturnedObject.self, from: response.data)
                    success(results)
                } catch {
                    let apiError = AppError(description: error.localizedDescription)
                    failure(apiError)
                }
                break
            case .failure(let error):
                let apiError = AppError(description: error.localizedDescription)
                failure(apiError)
            }
            shared.removeRequestFromList(apiRequest)
        })
        shared.requests.append(apiRequest)
    }
    
    
    static func cancelAll() {
        shared.requests.forEach {
            $0.cancellable.cancel()
        }
        shared.requests.removeAll()
    }
    
    static func cancelRequest(identifier: String) {
        if let request = shared.requests.first(where: { $0.identifier == identifier }) {
            request.cancellable.cancel()
            shared.removeRequestFromList(request)
        }
        
    }
}
