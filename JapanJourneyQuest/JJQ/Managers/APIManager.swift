//
//  APIManager.swift
//  JJQ
//
//  Created by 藤井陽介 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

    static let shared = APIManager()
    private let decoder = JSONDecoder()

    private var baseURLString = "https://www.chiikinogennki.soumu.go.jp/k-cloud-api/v001/kanko/"
    var templateRequest: URL? {

        return createRequest(
            for: ["町並み", "郷土景観", "展望施設",
                  "旧街道", "史跡", "地域風俗",
                  "温泉", "伝統工芸技術", "民宿"],
            with: [.limit(50)])
    }

    enum Params {
        case code([String])
        case coordinate(latitude: Double, longitude: Double, meters: Int)
        case facility([String])
        case name([String])
        case place([String])
        case desc(String)
        case count
        case limit(Int)
        case skip(Int)
    }

    func createRequest(for genres: [String], with parameters: [Params]) -> URL? {

        var requestURLString = baseURLString
        for i in 0 ..< genres.count {

            if i != 0 {
                requestURLString += ";"
            }
            requestURLString += genres[i].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        requestURLString += "/json"
        if parameters.count != 0 {

            requestURLString += "?"
            for i in 0 ..< parameters.count {

                if i != 0 {
                    requestURLString += "&"
                }
                switch parameters[i] {
                case .code(let codes):
                    requestURLString += "code="
                    requestURLString += createMultiQueries(codes)
                case .coordinate(let latitude, let longitude, let meters):
                    requestURLString += "coordinates=\(latitude),\(longitude),\(meters)"
                case .facility(let facilities):
                    requestURLString += "facility="
                    requestURLString += createMultiQueries(facilities)
                case .name(let names):
                    requestURLString += "name="
                    requestURLString += createMultiQueries(names)
                case .place(let places):
                    requestURLString += "place="
                    requestURLString += createMultiQueries(places)
                case .desc(let desc):
                    requestURLString += "desc=\(desc.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                case .count:
                    requestURLString += "count=true"
                case .limit(let limitNumber):
                    requestURLString += "limit=\(limitNumber)"
                case .skip(let skipNumber):
                    requestURLString += "skip=\(skipNumber)"
                }
            }
        }
        return URL(string: requestURLString)
    }

    func createImageRequest(_ image: Image?, _ mng: Management) -> URL? {

        guard let image = image else { return nil }

        var requestURLString = baseURLString + "view/"
        requestURLString += mng.refbase + "/"
        requestURLString += image.fid
        return URL(string: requestURLString)
    }

    func getInformations(_ url: URL, _ completion: @escaping ([Tourspot]) -> Void) {

        Alamofire.request(url).responseJSON { response in

            if let error = response.error {

                print("Response Error: \(error)")
                return
            }

            if let data = response.data {

                do {

                    let response = try self.decoder.decode(APIResponse.self, from: data)
                    completion(response.tourspots)
                } catch let error {

                    print("Parse Error: \(error)")
                    completion([])
                }
            }
        }
    }

    private func createMultiQueries(_ queries: [String]) -> String {

        var query = ""
        for i in 0 ..< queries.count {

            if i != 0 {
                query += ";"
            }
            query += queries[i].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        return query
    }
}

// MARK: - Model

struct Name: Codable {
    let written: String
    let spoken: String?
}

struct Names: Codable {
    let name1: Name?
    let name2: Name?
}

struct Image: Codable {
    let name: Name?
    let fid: String
}

struct Description: Codable {
    let body: String
}

struct Place: Codable {
    struct Coordinate: Codable {
        let longitude: String   // 経度
        let latitude: String    // 緯度
    }

    let coordinate: Coordinate?
    let city: Name?
    let street: Name?
    let building: Name?
    let phone: String?
    let email: String?
    let url: URL?
}

struct Foreign: Codable {
    struct Language: Codable {
        let lang1: String   // English
        let lang2: String   // 中国語（繁）
        let lang3: String   // 中国語（簡）
        let lang4: String   // 韓国語
        let lang5: String   // タイ語
        let lang6: String   // フランス語
        let lang7: String   // ドイツ語
        let lang8: String   // イタリア語
        let lang9: String   // ロシア語
        let lang10: String  // スペイン語
        let info: String?
    }

    let written: Language
    let speak: Language
}

struct Wifi: Codable {
    let established: String?
    let url: URL?
    let info: String?
}

struct Management: Codable {
    let refbase: String
    let refsub: Int?
}

struct Tourspot: Codable {
    let name: Names
    let views: [Image]?
    let descs: [Description]?
    let place: Place?
    let foreign: Foreign?
    let wifi: Wifi?
    let mng: Management
}

struct APIResponse: Codable {
    let tourspots: [Tourspot]
}
