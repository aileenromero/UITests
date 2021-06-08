//
//  Console.swift
//  App
//
//  Created by Maria Rosa Santiago on 6/7/21.
//  Copyright © 2021 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import Foundation

enum LogLevel: String {
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

class Console {
    
    static private func log(logLevel: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        var emoji = ""
        let filePath = (file as NSString).lastPathComponent
        let messageToPrint = " [\(logLevel.rawValue)/\(filePath)/\(function):\(line)> \(message)"
        
        switch logLevel {
        case .info:
            emoji = "✏️"
            print(emoji + messageToPrint)
        case .warning:
            emoji = "⚠️"
            print(emoji + messageToPrint)
        case .error:
            emoji = "⛔️"
            print(emoji + messageToPrint)
        }
    }
    
    /// Prints Info log level to console
    ///
    /// - parameters:
    ///     - message: The message to be printed to the console
    ///     - file: File where the log occurred
    ///     - function: Function where the log occurred
    ///     - line: Line of code where the log occurred
    static func logInfo(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        Console.log(logLevel: .info, message: message, file: file, function: function, line: line)
    }
    
    /// Prints Warning log level to console
    ///
    /// - parameters:
    ///     - message: The message to be printed to the console
    ///     - file: File where the log occurred
    ///     - function: Function where the log occurred
    ///     - line: Line of code where the log occurred
    static func logWarning(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        Console.log(logLevel: .warning, message: message, file: file, function: function, line: line)
    }
    
    /// Prints Error log level to console (Add your Crashlytics error logging here)
    ///
    /// - parameters:
    ///     - message: The message to be printed to the console
    ///     - file: File where the log occurred
    ///     - function: Function where the log occurred
    ///     - line: Line of code where the log occurred
    static func logError(error: Error, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        Console.log(logLevel: .error, message: message, file: file, function: function, line: line)
    }
}
