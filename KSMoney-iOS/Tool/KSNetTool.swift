//
//  KSNetTool.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/25.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import HandyJSON
import SwiftyUserDefaults

private let failureStr: String = "接口失败"
private let lackKeyErrorStr: String = "缺少字段"

struct KSNetTool {
    static func loginWithParams(_ params: [String: Any]? = nil, success : @escaping (_ response : KSLoginModel)->(), failure : @escaping (_ error : Error)->()) {
        Alamofire.request(ApiLogin.tokenUrl(), method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.result.value as? NSDictionary {
                    let model = KSLoginModel.deserialize(from: data)
                    Defaults[.token] = model?.token
                    //Defaults.set(model, forKey: "loginModel")
                    success(model!)
                } else {
                    //failure()
                }
            case .failure(let error):
                failure(error)
                print("error:\(error)")
            }
        }
    }

    static func getTallys(_ params: [String: Any], success: @escaping (_ response: [KSTallyModel])->(), failure: @escaping (_ error: String)->()) {
        request(ApiTally.tokenUrl(), method: .get, parameters: params, success: { (response) in
            if let data = response as? [String : Any] {
                let tallys = [KSTallyModel].deserialize(from: (data["tallys"] as! NSArray))
                success(tallys! as! [KSTallyModel])
            } else {
                failure(lackKeyErrorStr)
            }
        }) { (error) in
            failure(error)
        }

    }

    static func request(_ url: URLConvertible,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil,
                        success: @escaping (_ response: Any)->(),
                        failure: @escaping (_ error: String)->()) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String : Any] {
                    let code = data["code"] as! Int
                    if code == 0 {
                        success(data)
                    } else {
                        if let msg = data["message"] as? String {
                            if msg == "未登录" {
                                Defaults[.token] = nil
                                let window : UIWindow = (UIApplication.shared.delegate?.window!!)!
                                DispatchQueue.main.async {
                                    if !window.isKeyWindow {
                                        window.makeKeyAndVisible()
                                    }
                                    window.rootViewController = UINavigationController(rootViewController: KSLoginController())
                                }
                            } else {
                                failure(msg)
                            }
                        } else {
                            failure(failureStr)
                        }
                    }
                } else {
                    failure(failureStr)
                }
            case .failure(let error):
                failure("error:\(error)")
                print("error:\(error)")
            }
        }
    }
}



/*
 print("Request: \(String(describing: response.request))")   // original url request
 print("Response: \(String(describing: response.response))") // http url response
 print("Result: \(response.result)")                         // response serialization result

 if let json = response.result.value {

 print("JSON: \(json)") // serialized json response
 }

 if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
 print("Data: \(utf8Text)") // original server data as UTF8 string
 }
 */
