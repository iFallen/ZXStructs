//
//  Date.zx.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import Foundation

extension Date {
    public struct Current {
        /// current Date&Time
        /// Beijing
        /// - Parameters:
        ///   - chineseFormat: xxxx年xx月xx日 or xxxx-xx-xx
        ///   - timeWithSecond: 时间是否需要秒数
        /// - Returns: return value description
        public static func dateAndTime(_ chineseFormat:Bool,timeWithSecond:Bool) -> String{
            let formatter = DateFormatter()
            formatter.timeZone = Date.zx.CHNZONE()
            if chineseFormat {
                if timeWithSecond {
                    formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
                }else{
                    formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
                }
            }else {
                if timeWithSecond {
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                }else{
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                }
            }
            return formatter.string(from: Date())
        }
        
        /// currentDate
        /// Beijing
        /// - Parameter chineseFormat: xxxx年xx月xx日 or xxxx-xx-xx
        /// - Returns: return value description
        public static func date(_ chineseFormat:Bool) -> String{
            let formatter = DateFormatter()
            formatter.timeZone = Date.zx.CHNZONE()
            if chineseFormat {
                formatter.dateFormat = "yyyy年MM月dd日"
            }else {
                formatter.dateFormat = "yyyy-MM-dd"
            }
            return formatter.string(from: Date())
        }
        
        /// currentTime
        /// Beijing
        /// - Parameter timeWithSecond: 时间是否需要秒数
        /// - Returns: return value description
        public static func time(_ timeWithSecond:Bool) -> String{
            let formatter = DateFormatter()
            formatter.timeZone = Date.zx.CHNZONE()
            if timeWithSecond {
                formatter.dateFormat = "HH:mm:ss"
            }else{
                formatter.dateFormat = "HH:mm"
            }
            return formatter.string(from: Date())
        }
        
        /// Current MilliSecond
        ///
        /// - Returns: return value description
        public static func millisecond() -> Int64 {
            return Int64(Date().timeIntervalSince1970 * 1000)
        }
    }

    public struct zx {
        public static func CHNZONE() -> TimeZone {
            //return  NSTimeZone(name: "Asia/Beijing")
            return NSTimeZone(forSecondsFromGMT: +28800) as TimeZone
        }
        
        public static func beijingDate() -> Date {
            let timezone = self.CHNZONE()
            let date = Date()
            let interval = timezone.secondsFromGMT(for: date)
            return date.addingTimeInterval(TimeInterval(interval))
        }
        
        public struct millisecond {
            public static func dateformat(_ millisecond:Int64,
                                          format:String?) -> String {
                let formatter = DateFormatter()
                formatter.timeZone = Date.zx.CHNZONE()
                if let format = format {
                    formatter.dateFormat = format
                } else {
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                }
                return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
            }
            
            /// Date&Time from Millisecond
            /// Beijing
            /// - Parameters:
            ///   - millisecond: millisecond description
            ///   - chineseFormat: chineseFormat description
            ///   - timeWithSecond: timeWithSecond description
            /// - Returns: return value description
            public static func datetime(_ millisecond:Int64,
                                        chineseFormat:Bool,
                                        timeWithSecond:Bool) -> String {
                let formatter = DateFormatter()
                formatter.timeZone = Date.zx.CHNZONE()
                if chineseFormat {
                    if timeWithSecond {
                        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
                    }else{
                        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
                    }
                }else {
                    if timeWithSecond {
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    }else{
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    }
                }
                return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
            }
            
            /// Date from millisecond
            /// Beijing
            /// - Parameters:
            ///   - millisecond: millisecond description
            ///   - chineseFormat: chineseFormat description
            /// - Returns: return value description
            public static func date(_ millisecond:Int64,
                                    chinese:Bool) -> String {
                if chinese {
                    return Date.zx.millisecond.dateformat(millisecond,format: "yyyy年MM月dd日")
                } else {
                    return Date.zx.millisecond.dateformat(millisecond,format: "yyyy-MM-dd")
                }
            }
            
            /// Time from millisecond
            /// Beijing
            /// - Parameters:
            ///   - millisecond: millisecond description
            ///   - timeWithSecond: timeWithSecond description
            /// - Returns: return value description
            public static func time(_ millisecond:Int64,withSecond:Bool) -> String {
                let formatter = DateFormatter()
                formatter.timeZone = Date.zx.CHNZONE()
                if withSecond {
                    formatter.dateFormat = "HH:mm:ss"
                }else{
                    formatter.dateFormat = "HH:mm"
                }
                return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
            }
            
            /// Millisecond from date
            ///
            /// - Parameters:
            ///   - date: date description
            ///   - dateFormat: dateFormat description
            /// - Returns: return value description
            public static func fromDate(_ date:String,dateFormat:String!) -> Int64 {
                let formatter = DateFormatter()
                formatter.timeZone = Date.zx.CHNZONE()
                formatter.dateFormat = dateFormat
                if let date = formatter.date(from: date){
                    return Int64(date.timeIntervalSince1970 * 1000)
                }
                return 0
            }
        }
        
        /// Int To Time
        ///
        /// - Parameters:
        ///   - int: count
        ///   - c: component string
        /// - Returns: return value description
        public static func intToTime(_ int:TimeInterval,componentString c:String?) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let date = Date(timeInterval: int, since: formatter.date(from: "00:00:00")!)
            if let c = c {
                formatter.dateFormat = "HH\(c)mm\(c)ss"
            }else{
                formatter.dateFormat = "HH°mm′ss″"
            }
            return formatter.string(from: date)
        }
        
        
        public static func dateFromString(_ date:String,format:String) -> Date? {
            let formatter = DateFormatter()
            formatter.timeZone = self.CHNZONE() as TimeZone?
            formatter.dateFormat = format
            return formatter.date(from: date)
        }
    }
    
    public func zx_DateString(_ seperator:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: +28800) as TimeZone
        formatter.dateFormat = "yyyy\(seperator)MM\(seperator)dd"
        return formatter.string(from: self)
    }

}
