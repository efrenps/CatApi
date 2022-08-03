//
//  WSAPI.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import Foundation
import Alamofire

class WSAPI {
    private static let sharedWSAPI: WSAPI = {
        return WSAPI()
    }()
    
    class func shared() -> WSAPI {
        return sharedWSAPI
    }
    
    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private lazy var AlamofireManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        return Alamofire.Session(configuration: configuration)
    }()
    
    private func getURL(path: String) -> String {
        return "\(Constants.endpoint)\(path)"
    }
    
    private func executeRequest(url: String, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (_ jsonData: Data?, _ error: Error?) -> Void) {
        
        let encodedUrl = url.replacingOccurrences(of: " ", with: "%20")
        var httpHeaders: [HTTPHeader] = []
        httpHeaders.append(HTTPHeader(name: "x-api-key", value: Constants.apiKey))
        
        
        if (Constants.isDevelopment) {
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters ?? [:])
            
            print("\n[WS] \(method.rawValue) request \(encodedUrl)\n[WS BODY] \(String(data: jsonData, encoding: .utf8) ?? "")")
        }

        AlamofireManager.request(encodedUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(httpHeaders)).responseJSON { [unowned self] (response) in
            if (Constants.isDevelopment) {
                if let jsonData = response.data {
                    print("\n[WS] \(method.rawValue) response \(encodedUrl)\n[WS] \(String(data: jsonData, encoding: .utf8) ?? "")")
                }
                else {
                    print("\n[WS] \(method.rawValue) response \(encodedUrl)\n[WS] No response")
                }
            }
                        
            switch response.result {
            case .success(_):
                guard let jsonData = response.data else {
                    return
                }
                
                if(response.response!.statusCode >= 200 && response.response!.statusCode < 300){
                    completion(jsonData, nil)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadBreeds(completion: @escaping (_ response: [BreedListResponse]?, _ error: Error?) -> Void) {
        let url = getURL(path: "breeds")
        //edgeUrl = edgeUrl.replacingOccurrences(of: "v0", with: "v1")

       /* let parameters: [String: Any] = [
            "customer_reference_key": customerId, //customerId,
            "type": "Inquiry"
        ] */

        executeRequest(url: url, method: .get) { jsonData, error in
            if let jsonData = jsonData {
                if let sendResponse = try? self.decoder.decode([BreedListResponse].self, from: jsonData) {
                    completion(sendResponse, nil)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    
    func loadBreedDetail(breedId: String, completion: @escaping (_ response: BreedDetailResponse?, _ error: Error?) -> Void) {
        var url = getURL(path: "breeds/:breed_id")
        url = url.replacingOccurrences(of: ":breed_id", with: breedId)

        executeRequest(url: url, method: .get) { jsonData, error in
            if let jsonData = jsonData {
                if let sendResponse = try? self.decoder.decode(BreedDetailResponse.self, from: jsonData) {
                    completion(sendResponse, nil)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    
}
