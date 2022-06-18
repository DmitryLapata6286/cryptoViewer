//
//  APICaller.swift
//  CryptoObserver
//
//  Created by Dmitry Lapata on 18.06.22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey: String = "B30FC71F-808A-4FB2-BED0-C922E3650F73"
        static let assetsPoint = "https://rest-sandbox.coinapi.io/v1/assets/"
    }
    
    private init() {}
    
    public func getCoinsData(
        complition: @escaping (Result<[String], Error>) -> Void
    ) {
        guard let url = URL(string: "\(Constants.assetsPoint)?apikey=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                // TODO: - Decode response
            }
            catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
}
