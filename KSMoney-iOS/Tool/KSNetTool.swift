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

    static func getTallys(_ params: [String: Any], success: @escaping (_ response: [KSTallyModel])->(), failure: @escaping (_ eror: Error)->()) {
        Alamofire.request(ApiTally.tokenUrl(), method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.result.value as? NSDictionary {
                    let tallys = [KSTallyModel].deserialize(from: (data["tallys"] as! NSArray))
                    success(tallys! as! [KSTallyModel])
                }
            case .failure(let error):
                failure(error)
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
