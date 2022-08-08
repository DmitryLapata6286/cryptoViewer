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
    
    public var icons: [Icon] = []
    public var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    
    public func getCoinsData(
        completion: @escaping (Result<[Crypto], Error>) -> Void
    ) {
        guard !icons.isEmpty else {
            whenReadyBlock = completion
            return
        }
        
        guard let url = URL(string: "\(Constants.assetsPoint)?apikey=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let coins = try JSONDecoder().decode([Crypto].self, from: data)
                completion(.success(coins))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getCoinsImage () {
        guard let url = URL(string: "\(Constants.assetsPoint)icons/55/?apikey=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
        
            do {
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReadyBlock {
                    self?.getCoinsData(completion: completion)
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
