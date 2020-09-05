//
//  URLProtocolMock.swift
//  vogswiftchallenge
//
//  Created by Olaide Nojeem Ekeolere on 03/09/2020.
//  Copyright © 2020 Olaide Nojeem Ekeolere. All rights reserved.
//

import Foundation

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        //check for error then response before finally checking for testURLs
        
        //check error
        if let error = URLProtocolMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        //check response
        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        //check testURLs
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url]{
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
