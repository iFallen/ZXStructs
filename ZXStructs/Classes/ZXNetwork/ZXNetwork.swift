//
//  ZXNetwork.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 JuanFelix. All rights reserved.
//

import UIKit

public let ZXAPI_URL_ERROR:Int                 =   911911 //接口返回数据非json字典
public typealias ZXHTTPCompletionAction        = (Any?,String?) -> Void    //JsonObject,StringValue
public typealias ZXHTTPTimeOutAction           = (String) -> Void          //TimeOutMessage
public typealias ZXHTTPErrorAction             = (Int,String) -> Void      //Status,ErrorMsg

public enum ZXHTTPMethod {
    case get,post
    public func description() -> String{
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            
        }
    }
}

public class ZXNetwork: NSObject {
    public static var showRequestLog:Bool      = false
    public static var timeoutInterval:Double   = 10
    //{status:0,data:{},msg:"success"}
    private final class func commonProcess(data:Data?,
                                           url:String,
                                           completion:ZXHTTPCompletionAction?) {
        var contentString:String? = nil
        if let data = data {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                contentString = String(data: data, encoding: .utf8)
                completion?(obj,contentString!)
            } catch {
                contentString = String(data: data, encoding: .utf8)
                completion?(nil,contentString)
            }
        } else {
            completion?(nil,nil)
        }
        if showRequestLog {
            print("\n------------Response------------\n请求地址:\n\(url)\n接口返回数据:\n\(contentString ?? "")\n---------------------------\n")
        }
    }
    
    private final class func httpError(error:Error,
                                       url:String,
                                       timeout:ZXHTTPTimeOutAction?,
                                       httpError:ZXHTTPErrorAction?) {
        if showRequestLog {
            print("\n------------Response------------\n请求地址:\n\(url)\n错误:\n\(error)\n描述:\(error.localizedDescription)\n---------------------------\n")
        }
        let code = (error as NSError).code
        switch code {
            case NSURLErrorTimedOut:
                timeout?("请求数据超时")
            default:
                httpError?(code,error.localizedDescription)
        }
    }
    
    /// AsynRequest
    ///
    /// - Parameters:
    ///   - url: url
    ///   - params: params
    ///   - method: .get .post
    ///   - completion: server responsed
    ///   - timeOut: request timeout
    ///   - httpError: http request error
    /// - Returns: return value description
    @discardableResult final public class func zx_asyncRequest(withUrl url:String,
                                                               params:Dictionary<String, Any>?,
                                                               method:ZXHTTPMethod,
                                                               completion:ZXHTTPCompletionAction?,
                                                               timeOut:ZXHTTPTimeOutAction?,
                                                               httpError:ZXHTTPErrorAction?) -> URLSessionTask? {
        if showRequestLog {
            print("\n------------Request------------\n请求地址:\n\(url)\n请求参数:\n\(String(describing: params))\n---------------------------\n")
        }
        var paramsString: String?
        var arrParams:Array<String>?
        if let params = params,params.count > 0 {
            arrParams = []
            for (key,value) in params {
                if let str = value as? String {
                    let tempS = str.replacingOccurrences(of: "\\", with: "")
                    arrParams?.append("\(key)=\(tempS)")
                }else{
                    arrParams?.append("\(key)=\(value)")
                }
            }
            paramsString = arrParams?.joined(separator: "&")
            paramsString = paramsString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        var urlString = url
        if let paramsStr = paramsString,method == .get{
            urlString = "\(urlString)?\(paramsStr)"
        }
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url1 = URL(string:urlString) {
            let session = URLSession.shared
            var request = URLRequest(url: url1)
            request.httpMethod = method.description()
            request.timeoutInterval = timeoutInterval
            if let pStr = paramsString,method == .post {
                request.httpBody = pStr.data(using: .utf8)
            }
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    if let response = response as? HTTPURLResponse,response.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.commonProcess(data: data, url: url, completion: completion)
                        }
                    }  else {
                        DispatchQueue.main.async {
                            let response = response as! HTTPURLResponse
                            let error = NSError(domain: NSURLErrorDomain, code: response.statusCode, userInfo: nil)
                            self.httpError(error: error, url: url, timeout: timeOut, httpError: httpError)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.httpError(error: error!, url: url, timeout: timeOut, httpError: httpError)
                    }
                }
            })
            task.resume()
            return task
        } else {
            DispatchQueue.main.async {
                httpError?(ZXAPI_URL_ERROR,"URL地址错误")
            }
            if showRequestLog {
                print("\n------------Response------------\n请求地址:\n\(url)\n错误:URL地址错误\n---------------------------\n")
            }
        }
        return nil
    }
    
    /// Upload Image To Server
    ///
    /// - Parameters:
    ///   - url: url
    ///   - name: API Name (if nil name = "file")
    ///   - fileNames: fileNames(if nil filename = "yyyyMMddHHmmssSSS.jpg")
    ///   - images: image array
    ///   - params: post params
    ///   - compressRatio: 0 - max compress, 1 - min compress
    ///   - completion: server responsed
    ///   - timeOut: request timeout
    ///   - httpError: http request error
    /// - Returns: return value description
    @discardableResult public class func zx_uploadImage(to url:String!,
                                                        name:String?,
                                                        fileNames:Array<String>?,
                                                        images:Array<UIImage>!,
                                                        params:Dictionary<String,Any>?,
                                                        compressRatio:CGFloat,
                                                        completion:ZXHTTPCompletionAction?,
                                                        timeOut:ZXHTTPTimeOutAction?,
                                                        httpError:ZXHTTPErrorAction?) -> URLSessionTask? {
        if showRequestLog {
            print("\n------------Request------------\n请求地址:\n\(String(describing: url))\n请求参数:\n\(String(describing: params))\n---------------------------\n")
        }
        var paramsString: String?
        var arrParams:Array<String>?
        if let params = params,params.count > 0 {
            arrParams = []
            for (key,value) in params {
                arrParams?.append("\(key)=\(value)")
            }
            paramsString = arrParams?.joined(separator: "&")
            paramsString = paramsString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        var urlT = url
        urlT = urlT?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url1 = URL(string:url!) {
            let boundary: NSString = "----CustomFormBoundarycC4YiaUFwM44F6rT"
            let body: NSMutableData = NSMutableData()
            
            if let params = params {
                let paramsArray = params.keys
                for item in paramsArray {
                    body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                }
            }
            // you can also send multiple images
            let imageKey = name ?? "file"
            for i in (0..<images.count) {
                var fileName:String?
                if let fName = fileNames?[i] {
                    fileName = fName
                } else {
                    let formatter = DateFormatter();
                    formatter.dateFormat = "yyyyMMddHHmmssSSS";
                    fileName = formatter.string(from: Date())
                }
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"\(fileName!).jpg\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                // change quality of image here
                body.append(UIImageJPEGRepresentation(images[i], compressRatio)!)
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            var request = URLRequest(url: url1)
            request.httpMethod = "POST"
            request.httpBody = body as Data
            request.timeoutInterval = timeoutInterval
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    if let response = response as? HTTPURLResponse,response.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.commonProcess(data: data, url: url, completion: completion)
                        }
                    }else{
                        DispatchQueue.main.async {
                            let response = response as! HTTPURLResponse
                            let error = NSError(domain: NSURLErrorDomain, code: response.statusCode, userInfo: nil)
                            self.httpError(error: error, url: url, timeout: timeOut, httpError: httpError)
                        }
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.httpError(error: error!, url: url, timeout: timeOut, httpError: httpError)
                    }
                }
            })
            task.resume()
            return task
        } else {
            DispatchQueue.main.async {
                httpError?(ZXAPI_URL_ERROR,"URL地址错误")
            }
            if showRequestLog {
                print("\n------------Response------------\n请求地址:\n\(String(describing: url))\n错误:URL地址错误\n---------------------------\n")
            }
        }
        return nil
    }
    
    /// FileUpload
    ///
    /// - Parameters:
    ///   - url: url
    ///   - name: api Key name (if nil name = "file")
    ///   - fileNames: file Names
    ///   - fileDatas: file Datas
    ///   - mimeType: mimeType
    ///   - params: -
    ///   - completion: -
    ///   - timeOut: -
    ///   - httpError: -
    /// - Returns: -
    @discardableResult public class func zx_fileupload(to url:String!,
                                                       name:String?,
                                                       fileNames:Array<String>,
                                                       fileDatas:Array<Data>,
                                                       mimeType:String,
                                                       params:Dictionary<String,Any>?,
                                                       completion:ZXHTTPCompletionAction?,
                                                       timeOut:ZXHTTPTimeOutAction?,
                                                       httpError:ZXHTTPErrorAction?) -> URLSessionTask? {
        if showRequestLog {
            print("\n------------Request------------\n请求地址:\n\(String(describing: url))\n请求参数:\n\(String(describing: params))\n---------------------------\n")
        }
        var paramsString: String?
        var arrParams:Array<String>?
        if let params = params,params.count > 0 {
            arrParams = []
            for (key,value) in params {
                arrParams?.append("\(key)=\(value)")
            }
            paramsString = arrParams?.joined(separator: "&")
            paramsString = paramsString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        var urlT = url
        urlT = urlT?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url1 = URL(string:url!) {
            let boundary: NSString = "----CustomFormBoundarycC4YiaUFwM44F6rT"
            let body: NSMutableData = NSMutableData()
            //params
            if let params = params {
                let paramsArray = params.keys
                for item in paramsArray {
                    body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                    body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                }
            }
            for i in (0..<fileDatas.count) {
                var fileName:String?
                if i < fileNames.count {
                    fileName = fileNames[i]
                } else {
                    let formatter = DateFormatter();
                    formatter.dateFormat = "yyyyMMddHHmmssSSS";
                    fileName = formatter.string(from: Date())
                }
                //file
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\(name ?? "file")\"; filename=\"\(fileName!)\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                //filedata
                body.append(fileDatas[i])
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
            
            //footer
            body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            var request = URLRequest(url: url1)
            request.httpMethod = "POST"
            request.httpBody = body as Data
            request.timeoutInterval = timeoutInterval
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            let config: URLSessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    if let response = response as? HTTPURLResponse,response.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.commonProcess(data: data, url: url, completion: completion)
                        }
                    } else {
                        DispatchQueue.main.async {
                            let response = response as! HTTPURLResponse
                            let error = NSError(domain: NSURLErrorDomain, code: response.statusCode, userInfo: nil)
                            self.httpError(error: error, url: url, timeout: timeOut, httpError: httpError)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.httpError(error: error!, url: url, timeout: timeOut, httpError: httpError)
                    }
                }
            })
            task.resume()
            return task
        } else {
            DispatchQueue.main.async {
                httpError?(ZXAPI_URL_ERROR,"URL地址错误")
            }
            if showRequestLog {
                print("\n------------Response------------\n请求地址:\n\(String(describing: url))\n错误:URL地址错误\n---------------------------\n")
            }
        }
        return nil
    }
}
