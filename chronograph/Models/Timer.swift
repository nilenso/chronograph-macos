//
//  Timer.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 16/11/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation

struct TimeSpan: Codable, Equatable {
    let startedAt: Date
    let stoppedAt: Date!
    
    private enum CodingKeys: String, CodingKey {
        case startedAt = "started-at"
        case stoppedAt = "stopped-at"
    }
}

fileprivate func convertToDateInterval(timeSpan:TimeSpan, currentTime: Date) -> DateInterval {
    return DateInterval(start: timeSpan.startedAt, end: timeSpan.stoppedAt ?? currentTime)
}

struct Timer: Codable, Equatable {
    let id: String
    let note: String
    let taskID: Int
    let userID: Int
    let timeSpans: [TimeSpan]
    
    func totalDuration(currentTime: Date) -> TimeInterval {
        self.timeSpans
            .map {timeSpan in
                convertToDateInterval(timeSpan: timeSpan, currentTime: currentTime)
            }
            .map(\.duration)
            .reduce(0, {sum, timeInterval in
                return sum + timeInterval
            })
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case note
        case taskID = "task-id"
        case userID = "user-id"
        case timeSpans = "time-spans"
    }
}

struct TimerWithTask: Codable {
    let id: String
    let note: String
    let taskID: Int
    let userID: Int
    let timeSpans: [TimeSpan]
    let task: Task
    
    func withoutTask() -> Timer {
        return Timer(id: self.id, note: self.note, taskID: self.taskID, userID: self.userID, timeSpans: self.timeSpans)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case note
        case task
        case taskID = "task-id"
        case userID = "user-id"
        case timeSpans = "time-spans"
    }
}
