//
//  TimeUtils.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 16/11/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation


class TimeUtils {
    static func toDateString(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale  = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: from)
    }
}
