//
//  OSLog+Crashlytics.swift
//  App
//
//  Created by Zennon Gosalvez on 2018-07-15.
//  Copyright © 2019 ThinkBIT Solutions Phils. Inc. All rights reserved.
//

import os
import Foundation

/// Implements custom logs based on the [unified logging and tracing system](https://developer.apple.com/videos/play/wwdc2016/721) to write [custom logs](https://firebase.google.com/docs/crashlytics/customize-crash-reports#add_custom_logs)
/// to Firebase Crashlytics to enhance crash reports.
@available(iOS, introduced: 10.3)
extension OSLog {

    // MARK: - Properties:
    // MARK: Type

    /// The shared ModelController category log.
    @available(iOS, introduced: 10.3)
    static let modelController = OSLog(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "ModelController")

    /// The shared OtherController category log.
    @available(iOS, introduced: 10.3)
    static let otherController = OSLog(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "OtherController")

    /// The shared Resource category log.
    @available(iOS, introduced: 10.3)
    static let resource = OSLog(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "Resource")

    /// The shared ViewController category log.
    @available(iOS, introduced: 10.3)
    static let viewController = OSLog(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "ViewController")

    /// The shared View category log.
    @available(iOS, introduced: 10.3)
    static let view = OSLog(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "View")

    // MARK: - Methods:
    // MARK: File Private - Instance

    /// Formats the error and any user info as a string.
    /// **Example**
    /// ````
    /// OSLog.default.format(error, userInfo: userInfo)
    /// ````
    /// - parameter error: The error
    /// - parameter userInfo: The user info of the error and any additional user
    /// info. You should use this function after calling `userInfoForError()`
    @available(iOS, introduced: 10.3)
    fileprivate func format(
        _ error: Error,
        withUserInfo userInfo: [String: Any]? = nil
        ) -> String {
        var userInfo = userInfo

        userInfo?.removeValue(forKey: "function")
        userInfo?.removeValue(forKey: "file")
        userInfo?.removeValue(forKey: "line")

        if let userInfo = userInfo, userInfo.count > 0 {
            var description = error.localizedDescription

            if description.hasSuffix(".") || description.hasSuffix(",") {
                description.removeLast()
            }

            return "\(description), User info: \(userInfo.debugDescription)"
        } else {
            return error.localizedDescription
        }
    }

    /// Merges the user info of the error and any additional user info.
    /// Additional user info will have an "additional_" key prefix after.
    /// **Example**
    /// ````
    /// OSLog.default.userInfoForError(
    ///     error,
    ///     withAdditionalUserInfo: additionalUserInfo,
    ///     function: function,
    ///     file: file,
    ///     line: line)
    /// ````
    /// - parameter error: The error
    /// - parameter additionalUserInfo: The additional user info to merge with
    /// the error's user info
    /// - parameter function: The calling function
    /// - parameter file: The calling file
    /// - parameter line: The calling line
    fileprivate func userInfoForError(
        _ error: Error,
        withAdditionalUserInfo additionalUserInfo: [String: Any]? = nil,
        function: String,
        file: String,
        line: Int) -> [String: Any] {
        var userInfo = [String: Any]()

        if let additionalUserInfo = additionalUserInfo {
            for (key, value) in additionalUserInfo {
                userInfo.updateValue(value, forKey: "additional_\(key)")
            }
        }

        for (key, value) in (error as NSError).userInfo {
            userInfo.updateValue(value, forKey: key)
        }

        userInfo["function"] = function
        userInfo["file"] = URL(fileURLWithPath: file).lastPathComponent
        userInfo["line"] = line

        return userInfo
    }

    /// Prints a message to the log and Crashlytics.
    /// **Example**
    /// ````
    /// OSLog.default.write(type: .info, message: "Hello, world!")
    /// ````
    /// - parameter message: The message to print
    /// - parameter type: The log type
    /// - parameter function: The calling function
    /// - parameter file: The calling file
    /// - parameter line: The calling line
    @available(iOS, introduced: 10.3)
    fileprivate func write(
        _ message: String,
        type: OSLogType,
        function: String,
        file: String,
        line: Int
        ) {
//        let file = URL(fileURLWithPath: file).lastPathComponent
//
//        os_log(
//            "%{public}@ - %{public}@ (%{public}@:%d)",
//            log: self,
//            type: type,
//            message,
//            // Put these at the end to prevent the message from truncating.
//            function,
//            file,
//            line)
//
//        let prefix: String
//
//        switch type {
//        case .info:
//            prefix = "[INFO] "
//
//        case .debug:
//            prefix = "[DEBUG] "
//
//        case .error:
//            prefix = "[ERROR] "
//
//        case .fault:
//            prefix = "[FAULT] "
//
//        case .default:
//            fallthrough
//
//        default:
//            prefix = ""
//        }
//
//        let format = "%@%@ - %@ (%@:%d)"
//        let args: [CVarArg] = [
//            prefix,
//            message,
//            // Put these at the end to prevent the message from truncating.
//            function,
//            file,
//            line
//        ]

//        CLSLogv(format, getVaList(args)) // TODO: Uncomment this line after adding Crashlytics to your project...
    }
}

// MARK: - Functions:

/// Sends a default message to the logging system, optionally specifying a
/// custom log object.
/// **Example**
/// ````
/// os_log("Hello, world!", log: .viewController)
/// ````
/// - parameter message: A **public** string that produces a human-readable log
/// message.
/// - parameter log: A custom log object. If unspecified, the shared default log
/// is used.
/// - parameter function: The calling function
/// - parameter file: The calling file
/// - parameter line: The calling line
@available(iOS 10.3, *)
func os_log(
    _ message: String,
    log: OSLog = .default,
    function: String = #function,
    file: String = #file,
    line: Int = #line) {
    let type = OSLogType.default

    guard log.isEnabled(type: type) else { return }

    log.write(message,
              type: type,
              function: function,
              file: file,
              line: line)
}

/// Sends an info message to the logging system, optionally specifying a custom
/// log object.
/// **Example**
/// ````
/// os_log_info("Hello, world!", log: .viewController)
/// ````
/// - parameter message: A **public** string that produces a human-readable log
/// message.
/// - parameter log: A custom log object. If unspecified, the shared default log
/// is used.
/// - parameter function: The calling function
/// - parameter file: The calling file
/// - parameter line: The calling line
@available(iOS 10.3, *)
func os_log_info(
    _ message: String,
    log: OSLog = .default,
    function: String = #function,
    file: String = #file,
    line: Int = #line) {
    let type = OSLogType.info

    guard log.isEnabled(type: type) else { return }

    log.write(message,
              type: type,
              function: function,
              file: file,
              line: line)
}

/// Sends an debug message to the logging system, optionally specifying a custom
/// log object.
/// **Example**
/// ````
/// os_log_debug("Hello, world!", log: .viewController)
/// ````
/// - parameter message: A **public** string that produces a human-readable log
/// message.
/// - parameter log: A custom log object. If unspecified, the shared default log
/// is used.
/// - parameter function: The calling function
/// - parameter file: The calling file
/// - parameter line: The calling line
@available(iOS 10.3, *)
func os_log_debug(
    _ message: String,
    log: OSLog = .default,
    function: String = #function,
    file: String = #file,
    line: Int = #line) {
    let type = OSLogType.debug

    guard log.isEnabled(type: type) else { return }

    log.write(message,
              type: type,
              function: function,
              file: file,
              line: line)
}

/// Sends an error message to the logging system, optionally specifying a custom
/// log object.
/// **Example**
/// ````
/// os_log_error("Hello, world!", log: .viewController)
/// ````
/// - parameter error: A **public** error that will produce a human-readable log
/// message.
/// - parameter log: A custom log object. If unspecified, the shared default log
/// is used.
/// - parameter function: The calling function
/// - parameter file: The calling file
/// - parameter line: The calling line
@available(iOS 10.3, *)
func os_log_error(
    _ error: Error,
    withAdditionalUserInfo additionalUserInfo: [String: Any]? = nil,
    log: OSLog = .default,
    function: String = #function,
    file: String = #file,
    line: Int = #line) {
    let type = OSLogType.error

    guard log.isEnabled(type: type) else { return }

    let userInfo = log.userInfoForError(
        error,
        withAdditionalUserInfo: additionalUserInfo,
        function: function,
        file: file,
        line: line)

//    Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: userInfo) // Uncomment this line after adding Crashlytics to your project...

    log.write(log.format(error, withUserInfo: userInfo),
              type: type,
              function: function,
              file: file,
              line: line)
}

/// Sends a fault message to the logging system, optionally specifying a custom
/// log object.
/// **Example**
/// ````
/// os_log_fault("Hello, world!", log: .viewController)
/// ````
/// - parameter error: A **public** error that will produce a human-readable log
/// message.
/// - parameter log: A custom log object. If unspecified, the shared default log
/// is used.
/// - parameter function: The calling function
/// - parameter file: The calling file
/// - parameter line: The calling line
@available(iOS 10.3, *)
func os_log_fault(
    _ error: Error,
    withAdditionalUserInfo additionalUserInfo: [String: Any]? = nil,
    log: OSLog = .default,
    function: String = #function,
    file: String = #file,
    line: Int = #line) {
    let type = OSLogType.fault

    guard log.isEnabled(type: type) else { return }

    let userInfo = log.userInfoForError(
        error,
        withAdditionalUserInfo: additionalUserInfo,
        function: function,
        file: file,
        line: line)

//    Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: userInfo) // Uncomment this line after adding Crashlytics to your project...

    log.write(log.format(error, withUserInfo: userInfo),
              type: type,
              function: function,
              file: file,
              line: line)
}
