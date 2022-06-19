//
//  Models.swift
//  CryptoObserver
//
//  Created by Dmitry Lapata on 19.06.22.
//

import Foundation

struct Crypto: Codable {
    let assetID, name: String?
    let typeIsCrypto: Int?
    let dataQuoteStart, dataQuoteEnd, dataTradeStart, dataTradeEnd: String?
    let dataSymbolsCount: Int?
    let volume1HrsUsd, volume1DayUsd, volume1MthUsd, priceUsd: Float?
    let dataStart, dataEnd: String?

    enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case typeIsCrypto = "type_is_crypto"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1HrsUsd = "volume_1hrs_usd"
        case volume1DayUsd = "volume_1day_usd"
        case volume1MthUsd = "volume_1mth_usd"
        case priceUsd = "price_usd"
        case dataStart = "data_start"
        case dataEnd = "data_end"
    }
}
