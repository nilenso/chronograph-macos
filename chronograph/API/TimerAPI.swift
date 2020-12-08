//
//  TimerAPI.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 16/11/20.

//

import Foundation
import Alamofire
import Combine

struct TimersResponse: Codable {
    let timers: [TimerWithTask]
}

class TimerAPI {
    let credentials: Credentials

    init(credentials: Credentials) {
        self.credentials = credentials
    }
    
    func listByDate(recordedFor: Date) -> AnyPublisher<Result<[TimerWithTask], AFError>, Never> {
        let headers: HTTPHeaders = [.authorization(bearerToken: self.credentials.token)]
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom {decoder in
            let dateString: String = try decoder.singleValueContainer().decode(String.self)
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)

            return formatter.date(from: dateString)!
        }
        return AF.request(Config.timersURL(), parameters: ["day": TimeUtils.toDateString(from: recordedFor)], headers: headers)
            .publishDecodable(type: TimersResponse.self, decoder: decoder)
            .result()
            .map({result in
                return result.map(\.timers)
            })
            .eraseToAnyPublisher()
    }
}
