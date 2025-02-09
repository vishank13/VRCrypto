import Foundation

/// A **utility struct** to handle date formatting.
///
/// - Converts an **ISO 8601 date string** into a user-specified format.
/// - Uses an **enum `DateFormat`** to prevent format typos.
/// - **Handles format mismatches** by attempting multiple known formats.
///
/// # Example Usage:
/// ```swift
/// let formattedDate = DateHelper.formatDate("2013-07-06T00:00:00.000Z", to: .longDate)
/// print(formattedDate) // Output: "06 Jul 2013"
/// ```
///
/// - Author: Vishank Raghav
/// - Version: 1.2
///
struct DateHelper {
    
    /// **Date Format Enum**: Contains commonly used date formats.
    ///
    /// - `full`: "EEEE, MMMM d, yyyy" → `"Saturday, July 6, 2013"`
    /// - `longDate`: "dd MMM yyyy" → `"06 Jul 2013"`
    /// - `shortDate`: "MM/dd/yyyy" → `"07/06/2013"`
    /// - `timeOnly`: "HH:mm a" → `"14:30 PM"`
    /// - `monthYear`: "MMMM yyyy" → `"July 2013"`
    /// - `iso8601`: Standard ISO 8601 format
    ///
    enum DateFormat: String {
        case full = "EEEE, MMMM d, yyyy"            // "Saturday, July 6, 2013"
        case longDate = "dd MMM yyyy"               // "06 Jul 2013"
        case shortDate = "MM/dd/yyyy"               // "07/06/2013"
        case timeOnly = "HH:mm a"                   // "14:30 PM"
        case monthYear = "MMMM yyyy"                // "July 2013"
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Standard ISO 8601 format
    }
    
    /// **Primary function:** Converts an **ISO 8601 date string** into the desired format.
    ///
    /// - Parameters:
    ///   - isoDate: The date string in **ISO 8601 format** (e.g., `"2013-07-06T00:00:00.000Z"`).
    ///   - format: The desired `DateFormat` enum case (e.g., `.longDate`).
    /// - Returns: A **formatted date string**, or `"Invalid Date"` if conversion fails.
    ///
    static func formatDate(_ isoDate: String?, to format: DateFormat) -> String {
        guard let isoDate,
              let date = parseDate(from: isoDate) else {
            return "Invalid Date"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        return formatter.string(from: date)
    }
    
    /// **Handles format mismatches** by trying multiple known formats.
    ///
    /// - Parameter dateString: The input date string (which may have an unknown format).
    /// - Returns: A `Date` object if parsing is successful, otherwise `nil`.
    ///
    private static func parseDate(from dateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ISO 8601 format
        
        if let date = isoFormatter.date(from: dateString) {
            return date
        }
        
        // **Fallback: Try common date formats**
        let knownFormats = [
            "yyyy-MM-dd HH:mm:ss",       // "2013-07-06 14:30:00"
            "yyyy-MM-dd'T'HH:mm:ssZ",    // "2013-07-06T14:30:00Z"
            "yyyy/MM/dd HH:mm",          // "2013/07/06 14:30"
            "dd-MM-yyyy HH:mm",          // "06-07-2013 14:30"
            "dd/MM/yyyy HH:mm",          // "06/07/2013 14:30"
            "yyyy-MM-dd"                 // "2009-01-03"
        ]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in knownFormats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        return nil  // If all parsing attempts fail
    }
}
