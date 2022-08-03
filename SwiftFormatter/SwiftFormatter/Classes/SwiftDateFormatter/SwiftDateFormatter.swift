//
//  BaseViewController.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/8.
//

import UIKit

final public class SwiftDateFormatter {
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        return formatter
    }()
    
    private let locale: Locale?
    
    public init(locale: Locale? = nil) {
        self.locale = locale
    }
    
    public func dateString(from timestamp: TimeInterval, with format: String) -> String? {
        dateFormatter.dateFormat = format
        let date = dateSince1970From(timestamp)
        return dateFormatter.string(from: date)
    }
    
    public func dateSince1970From(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
}
