//
//  ApiManager.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Foundation


class APIManager {
    
    
    typealias SuccessResponse = (JSON) -> Void
    typealias FailureResponse = (Error) -> Void
    
    
    static let sharedInstance = APIManager()
    
    
    
    private init(){}
    
    
    
    func getHeader() -> HTTPHeaders {
        let headers:HTTPHeaders = ["Accept": "application/json"]
        return headers
    }
    
    
    func getHeaderAfterLogin() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Accept", value: "application/json")
        if let token = UserDefaults.standard.string(forKey: "BearerToken") {
            print(token)
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        return headers
    }
    
    
   //  2)Home Data
    func Home(success: @escaping(HomeData) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)"
        print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let otpVerify = try jsonDecoder.decode(HomeData.self, from: try! response.result.get())
                        success(otpVerify)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                            do{
                                let otpVerify = try jsonDecoder.decode(HomeData.self, from: try! response.result.get())
                                success(otpVerify)
                            }catch{
                                print("Error while decoding \(error)")
                                do{
                                    let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                    failure(networkError)
                                }catch{
                                    print("Error while decoding \(error)")
                                }
                            }
                        }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    //  vendor Detail
    func vendorDetail(with param: [String:Any], success: @escaping(VedorDetail) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.vendorDetail)\(id ?? "")"
        print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let otpVerify = try jsonDecoder.decode(VedorDetail.self, from: try! response.result.get())
                        success(otpVerify)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                      do{
                          let otpVerify = try jsonDecoder.decode(VedorDetail.self, from: try! response.result.get())
                          success(otpVerify)
                      }catch{
                          print("Error while decoding \(error)")
                          do{
                              let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                              failure(networkError)
                          }catch{
                              print("Error while decoding \(error)")
                          }
                      }
                  }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    
    func filterVenders(with parameters: [String: Any], amaneties: [Int] = [], success: @escaping(VendorsFilterModel) -> Void, failure: @escaping(NetworkError?) -> Void) {
        var url = GlobalConstantClass.APIConstantNames.filter
        if !amaneties.isEmpty {
            url = GlobalConstantClass.APIConstantNames.filter + "?"
            for value in amaneties {
                if value == amaneties.last {
                    url.append("customCheck[]=\(value)")
                } else {
                    url.append("customCheck[]=\(value)&")
                }
            }
        }
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: getHeaderAfterLogin())
            .responseData { response in
                print("URL: ", response.request?.url as Any)
                print("Status Code: ", response.response?.statusCode as Any)
                print("Headers: ", response.response?.headers as Any)
                if let requestData = response.value {
                    print("Response Data : ", String(data: requestData, encoding: .utf8) ?? "No data")
                    
                    switch Helper.optionalIntToInt(value: response.response?.statusCode) {
                    case 200:
                        do {
                            let filter = try JSONDecoder().decode(VendorsFilterModel.self, from: requestData)
                            success(filter)
                        } catch {
                            print("Error while decoding \(error)")
                            do {
                                let networkError = try JSONDecoder().decode(NetworkError.self, from: requestData)
                                failure(networkError)
                            } catch {
                                print("Error while decoding \(error)")
                                failure(NetworkError(msg: "Please try again after some time."))
                            }
                        }
                    case 500:
                        do {
                            let networkError = try JSONDecoder().decode(NetworkError.self, from: requestData)
                            failure(networkError)
                        } catch {
                            failure(NetworkError(msg: "Please try again after some time."))
                        }
                    default:
                        failure(NetworkError(msg: "Please try again after some time."))
                    }
                }
            }
    }
    
    
    
    func search(with param: [String : Any], success: @escaping(SearchModel) -> Void, failure: @escaping(NetworkError?) -> Void) {
        let url = GlobalConstantClass.APIConstantNames.search
        AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin())
            .responseData { response in
                print("URL: ", response.request?.url as Any)
                print("Status Code: ", response.response?.statusCode as Any)
                print("Headers: ", response.response?.headers as Any)
                if let requestData = response.value {
                    print("Response Data : ", String(data: requestData, encoding: .utf8) ?? "No data")
                    
                    switch Helper.optionalIntToInt(value: response.response?.statusCode) {
                    case 200:
                        do {
                            let search = try JSONDecoder().decode(SearchModel.self, from: requestData)
                            success(search)
                        } catch {
                            print("Error while decoding \(error)")
                            do {
                                let networkError = try JSONDecoder().decode(NetworkError.self, from: requestData)
                                failure(networkError)
                            } catch {
                                print("Error while decoding \(error)")
                                failure(NetworkError(msg: "Please try again after some time."))
                            }
                        }
                    case 500:
                        do {
                            let networkError = try JSONDecoder().decode(NetworkError.self, from: requestData)
                            failure(networkError)
                        } catch {
                            failure(NetworkError(msg: "Please try again after some time."))
                        }
                    default:
                        failure(NetworkError(msg: "Please try again after some time."))
                    }
                }
            }
    }
    
    
    
    
// vendor Filter
func vendorFilter(with param: [String:Any], success: @escaping(VendorsFilterModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let id = param["id"]
        let num = param["number"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.filtervendor)\(id ?? "")&page=\(num ?? 0)"
        print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do {
                        let filter = try jsonDecoder.decode(VendorsFilterModel.self, from: try! response.result.get())
                        success(filter)
                    } catch {
                        print("Error while decoding \(error)")
                        do {
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        } catch {
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                     do {
                         let filter = try jsonDecoder.decode(VendorsFilterModel.self, from: try! response.result.get())
                         success(filter)
                     } catch {
                         print("Error while decoding \(error)")
                         do {
                             let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                             failure(networkError)
                         } catch {
                             print("Error while decoding \(error)")
                         }
                     }
                 }
            case .failure:
                do {
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    } else {
                        failure(nil)
                    }
                } catch {
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    // vendor Filter
    func vendorFilterLocation(with param: [String:Any], success: @escaping(VendorFilter) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let id = param["id"]
        let num = param["number"]

 //       https://wed-advisor.com/find-vendor?location=2
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)/find-vendor?location=\(id ?? 0)&page=\(num ?? 0)"
        print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let filter = try jsonDecoder.decode(VendorFilter.self, from: try! response.result.get())
                        success(filter)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                       do{
                           let filter = try jsonDecoder.decode(VendorFilter.self, from: try! response.result.get())
                           success(filter)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    //  vendor Detail
    func blogListing(success: @escaping(BlogList) -> Void, failure: @escaping(NetworkError?) -> Void ){
       // let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.bloglist)"
        print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let otpVerify = try jsonDecoder.decode(BlogList.self, from: try! response.result.get())
                        success(otpVerify)
                     

                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                
                if (response.response?.statusCode == 500) {
                    do{
                        let otpVerify = try jsonDecoder.decode(BlogList.self, from: try! response.result.get())
                        success(otpVerify)
                     

                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }

                
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    
}
    
    
    
    // vendor Filter
    func vendorFilterData(with param: [String:Any], success: @escaping(VendorFilter) -> Void, failure: @escaping(NetworkError?) -> Void ){
      // let id = param["id"]
        let vendor = param["vendor_type"]
        let location = param["location"]
        let rating = param["ratings"]

        let clear = param["clear"] as! Bool
        var newurl : String!
        if clear == true{
        let url = "https://wed-advisor.com/find-vendor?_token=ChKNNhqT88ZBgugrz3JbrCJQ2RdGMG3cI8Y0IO9y&vendor_type=&location=&ratings="
            newurl = url
        }
        else{
        let url = "https://wed-advisor.com/find-vendor?_token=ChKNNhqT88ZBgugrz3JbrCJQ2RdGMG3cI8Y0IO9y&vendor_type=\(vendor ?? "")&location=\(location ?? "")&ratings=\(rating ?? "")"
            newurl = url

        }
        print(newurl)
        AF.request(newurl, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let filter = try jsonDecoder.decode(VendorFilter.self, from: try! response.result.get())
                        success(filter)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                    do{
                        let filter = try jsonDecoder.decode(VendorFilter.self, from: try! response.result.get())
                        success(filter)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    //SignUp
    func SignUpUser(with param: [String:Any], success: @escaping(SignUp) -> Void, failure: @escaping(NetworkError?) -> Void ){
        //let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.signup)"
        print(url)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeader()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(SignUp.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                if (response.response?.statusCode == 500) {
                    do{
                        let sign = try jsonDecoder.decode(SignUp.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    //SignUp
       func LoginUser(with param: [String:Any], success: @escaping(SignUp) -> Void, failure: @escaping(NetworkError?) -> Void ){
           //let id = param["id"]
           let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.login)"
           print(url)
           AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeader()).responseData { (response) in
               let jsonDecoder = JSONDecoder()
               switch response.result {
               case .success:
                   if (response.response?.statusCode == 200) {
                       do{
                           let sign = try jsonDecoder.decode(SignUp.self, from: try! response.result.get())
                           success(sign)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
                    
                    if (response.response?.statusCode == 500) {
                         do{
                             let sign = try jsonDecoder.decode(SignUp.self, from: try! response.result.get())
                             success(sign)
                         }catch{
                             print("Error while decoding \(error)")
                             do{
                                 let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                 failure(networkError)
                             }catch{
                                 print("Error while decoding \(error)")
                             }
                         }
                     }
               else if (response.response?.statusCode == 401) {
                    do{
                        let sign = try jsonDecoder.decode(SignUp.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
               case .failure:
                   do{
                       if let data = try? response.result.get(){
                           let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                           failure(networkError)
                       }else{
                           failure(nil)
                       }
                   }catch{
                       print("Error while decoding \(error)")
                   }
               }
           }
       }
    
    
     //  Gallery Detail
    func galleryListing(with param: [String:Any], success: @escaping(galleryModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
            let id = param["page"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.gallery)\(id ?? 1)"
            print(url)
            AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                let jsonDecoder = JSONDecoder()
                switch response.result {
                case .success:
                    if (response.response?.statusCode == 200) {
                        do{
                            let otpVerify = try jsonDecoder.decode(galleryModel.self, from: try! response.result.get())
                            success(otpVerify)
                         

                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                    if (response.response?.statusCode == 500) {
                        do{
                            let otpVerify = try jsonDecoder.decode(galleryModel.self, from: try! response.result.get())
                            success(otpVerify)
                         

                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                case .failure:
                    do{
                        if let data = try? response.result.get(){
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                            failure(networkError)
                        }else{
                            failure(nil)
                        }
                    }catch{
                        print("Error while decoding \(error)")
                    }
                }
            }
        
    }
    
    
    //Forgot
    func ForgotUser(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        //let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.forgot)"
        print(url)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeader()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                    if (response.response?.statusCode == 500) {
                        do{
                            let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                            success(sign)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
            else if (response.response?.statusCode == 401) {
                 do{
                     let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                     success(sign)
                 }catch{
                     print("Error while decoding \(error)")
                     do{
                         let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                         failure(networkError)
                     }catch{
                         print("Error while decoding \(error)")
                     }
                 }
             }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
      //  Dashboard Detail
        func dashboardData(success: @escaping(dashboardModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
           // let id = param["id"]
            let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.dashboard)"
            print(url)
            AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                let jsonDecoder = JSONDecoder()
                switch response.result {
                case .success:
                    if (response.response?.statusCode == 200) {
                        do{
                            let dashboard = try jsonDecoder.decode(dashboardModel.self, from: try! response.result.get())
                            success(dashboard)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                    if (response.response?.statusCode == 500) {
                          do{
                              let dashboard = try jsonDecoder.decode(dashboardModel.self, from: try! response.result.get())
                              success(dashboard)
                          }catch{
                              print("Error while decoding \(error)")
                              do{
                                  let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                  failure(networkError)
                              }catch{
                                  print("Error while decoding \(error)")
                              }
                          }
                      }
                case .failure:
                    do{
                        if let data = try? response.result.get(){
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                            failure(networkError)
                        }else{
                            failure(nil)
                        }
                    }catch{
                        print("Error while decoding \(error)")
                    }
                }
            }
    }
    
    
     //  MyWishList Detail
        func MyWishlist(success: @escaping(MywishListModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
           // let id = param["id"]
            let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.myWishList)"
            print(url)
            AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                let jsonDecoder = JSONDecoder()
                switch response.result {
                case .success:
                    if (response.response?.statusCode == 200) {
                        do{
                            let wish = try jsonDecoder.decode(MywishListModel.self, from: try! response.result.get())
                            success(wish)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                    if (response.response?.statusCode == 500) {
                        do{
                            let wish = try jsonDecoder.decode(MywishListModel.self, from: try! response.result.get())
                            success(wish)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                case .failure:
                    do{
                        if let data = try? response.result.get(){
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                            failure(networkError)
                        }else{
                            failure(nil)
                        }
                    }catch{
                        print("Error while decoding \(error)")
                    }
                }
            }
    }
    
    
    //removeWishList
          func removeWishList(with param: [String:Any], success: @escaping(RemoveWish) -> Void, failure: @escaping(NetworkError?) -> Void ){
              //let id = param["id"]
              let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.removeWishList)"
              print(url)
              AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                  let jsonDecoder = JSONDecoder()
                  switch response.result {
                  case .success:
                      if (response.response?.statusCode == 200) {
                          do{
                              let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                              success(wish)
                          }catch{
                              print("Error while decoding \(error)")
                              do{
                                  let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                  failure(networkError)
                              }catch{
                                  print("Error while decoding \(error)")
                              }
                          }
                      }
                        if (response.response?.statusCode == 500) {
                            do{
                                let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                                success(wish)
                            }catch{
                                print("Error while decoding \(error)")
                                do{
                                    let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                    failure(networkError)
                                }catch{
                                    print("Error while decoding \(error)")
                                }
                            }
                        }
                  else if (response.response?.statusCode == 401) {
                       do{
                           let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                           success(wish)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
                  case .failure:
                      do{
                          if let data = try? response.result.get(){
                              let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                              failure(networkError)
                          }else{
                              failure(nil)
                          }
                      }catch{
                          print("Error while decoding \(error)")
                      }
                  }
              }
          }
    
    //removeWishList
    func addWishList(with param: [String:Any], success: @escaping(RemoveWish) -> Void, failure: @escaping(NetworkError?) -> Void ){
        //let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.addWishList)"
        print(url)
        print(param)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                        success(wish)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                    if (response.response?.statusCode == 500) {
                              do{
                                  let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                                  success(wish)
                              }catch{
                                  print("Error while decoding \(error)")
                                  do{
                                      let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                      failure(networkError)
                                  }catch{
                                      print("Error while decoding \(error)")
                                  }
                              }
                          }
            else if (response.response?.statusCode == 401) {
                 do{
                     let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                     success(wish)
                 }catch{
                     print("Error while decoding \(error)")
                     do{
                         let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                         failure(networkError)
                     }catch{
                         print("Error while decoding \(error)")
                     }
                 }
             }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    
    func MyProfile(success: @escaping(MyProfileModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
             // let id = param["id"]
              let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.myProfile)"
              print(url)
              AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                  let jsonDecoder = JSONDecoder()
                  switch response.result {
                  case .success:
                      if (response.response?.statusCode == 200) {
                          do{
                              let wish = try jsonDecoder.decode(MyProfileModel.self, from: try! response.result.get())
                              success(wish)
                          }catch{
                              print("Error while decoding \(error)")
                              do{
                                  let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                  failure(networkError)
                              }catch{
                                  print("Error while decoding \(error)")
                              }
                          }
                      }
                    if (response.response?.statusCode == 500) {
                                 do{
                                     let wish = try jsonDecoder.decode(MyProfileModel.self, from: try! response.result.get())
                                     success(wish)
                                 }catch{
                                     print("Error while decoding \(error)")
                                     do{
                                         let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                         failure(networkError)
                                     }catch{
                                         print("Error while decoding \(error)")
                                     }
                                 }
                             }
                  case .failure:
                      do{
                          if let data = try? response.result.get(){
                              let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                              failure(networkError)
                          }else{
                              failure(nil)
                          }
                      }catch{
                          print("Error while decoding \(error)")
                      }
                  }
              }
      }
    
    
    //removeWishList
    func changePassword(with param: [String:Any], success: @escaping(RemoveWish) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.changePassword)"
        print(url)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let pass = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                        success(pass)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
                    if (response.response?.statusCode == 500) {
                        do{
                            let pass = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                            success(pass)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
            else if (response.response?.statusCode == 401) {
                 do{
                     let wish = try jsonDecoder.decode(RemoveWish.self, from: try! response.result.get())
                     success(wish)
                 }catch{
                     print("Error while decoding \(error)")
                     do{
                         let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                         failure(networkError)
                     }catch{
                         print("Error while decoding \(error)")
                     }
                 }
             }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    //  Blog Detail
     func blogDetails(with param: [String:Any], success: @escaping(BlogDetailModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
             let id = param["id"]
         let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.blogdetail)\(id ?? 1)"
             print(url)
             AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                 let jsonDecoder = JSONDecoder()
                 switch response.result {
                 case .success:
                     if (response.response?.statusCode == 200) {
                         do{
                             let otpVerify = try jsonDecoder.decode(BlogDetailModel.self, from: try! response.result.get())
                             success(otpVerify)
                         }catch{
                             print("Error while decoding \(error)")
                             do{
                                 let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                 failure(networkError)
                             }catch{
                                 print("Error while decoding \(error)")
                             }
                         }
                     }
                    if (response.response?.statusCode == 500) {
                        do{
                            let otpVerify = try jsonDecoder.decode(BlogDetailModel.self, from: try! response.result.get())
                            success(otpVerify)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                 case .failure:
                     do{
                         if let data = try? response.result.get(){
                             let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                             failure(networkError)
                         }else{
                             failure(nil)
                         }
                     }catch{
                         print("Error while decoding \(error)")
                     }
                 }
             }
     }
   
 //ToDoList
    func TodoList(success: @escaping(ToDoModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
                 let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.todocount)"
                 print(url)
                 AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                     let jsonDecoder = JSONDecoder()
                     switch response.result {
                     case .success:
                         if (response.response?.statusCode == 200) {
                             do{
                                 let todo = try jsonDecoder.decode(ToDoModel.self, from: try! response.result.get())
                                 success(todo)
                             }catch{
                                 print("Error while decoding \(error)")
                                 do{
                                     let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                     failure(networkError)
                                 }catch{
                                     print("Error while decoding \(error)")
                                 }
                             }
                         }
                        if (response.response?.statusCode == 500) {
                                  do{
                                      let todo = try jsonDecoder.decode(ToDoModel.self, from: try! response.result.get())
                                      success(todo)
                                  }catch{
                                      print("Error while decoding \(error)")
                                      do{
                                          let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                          failure(networkError)
                                      }catch{
                                          print("Error while decoding \(error)")
                                      }
                                  }
                              }
                     case .failure:
                         do{
                             if let data = try? response.result.get(){
                                 let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                                 failure(networkError)
                             }else{
                                 failure(nil)
                             }
                         }catch{
                             print("Error while decoding \(error)")
                         }
                     }
                 }
         }
   
    
    //ToDoList
    func TodoListData(success: @escaping(ToDoModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
                 let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.todocountListing)"
                 print(url)
                 AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                     let jsonDecoder = JSONDecoder()
                     switch response.result {
                     case .success:
                         if (response.response?.statusCode == 200) {
                             do{
                                 let todo = try jsonDecoder.decode(ToDoModel.self, from: try! response.result.get())
                                 success(todo)
                             }catch{
                                 print("Error while decoding \(error)")
                                 do{
                                     let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                     failure(networkError)
                                 }catch{
                                     print("Error while decoding \(error)")
                                 }
                             }
                         }
                        if (response.response?.statusCode == 500) {
                                do{
                                    let todo = try jsonDecoder.decode(ToDoModel.self, from: try! response.result.get())
                                    success(todo)
                                }catch{
                                    print("Error while decoding \(error)")
                                    do{
                                        let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                        failure(networkError)
                                    }catch{
                                        print("Error while decoding \(error)")
                                    }
                                }
                            }
                     case .failure:
                         do{
                             if let data = try? response.result.get(){
                                 let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                                 failure(networkError)
                             }else{
                                 failure(nil)
                             }
                         }catch{
                             print("Error while decoding \(error)")
                         }
                     }
                 }
         }
    
    
    //Add Task
       func addTaskTodo(with param: [String:Any], success: @escaping(AddToDoModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
           let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.todiaddTask)"
           print(url)
           print(param)
           AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
               let jsonDecoder = JSONDecoder()
               switch response.result {
               case .success:
                   if (response.response?.statusCode == 200) {
                       do{
                           let sign = try jsonDecoder.decode(AddToDoModel.self, from: try! response.result.get())
                           success(sign)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
                if (response.response?.statusCode == 500) {
                       do{
                           let sign = try jsonDecoder.decode(AddToDoModel.self, from: try! response.result.get())
                           success(sign)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
               case .failure:
                   do{
                       if let data = try? response.result.get(){
                           let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                           failure(networkError)
                       }else{
                           failure(nil)
                       }
                   }catch{
                       print("Error while decoding \(error)")
                   }
               }
           }
       }
       
    
    //deleteTask
    func deleteTask(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        //let id = param["id"]
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.deleteTask)"
        print(url)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            else if (response.response?.statusCode == 401) {
                 do{
                     let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                     success(sign)
                 }catch{
                     print("Error while decoding \(error)")
                     do{
                         let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                         failure(networkError)
                     }catch{
                         print("Error while decoding \(error)")
                     }
                 }
             }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    
    //Add Task
        func editTaskTodo(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
            let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.editTask)"
            print(url)
            print(param)
            AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                let jsonDecoder = JSONDecoder()
                switch response.result {
                case .success:
                    if (response.response?.statusCode == 200) {
                        do{
                            let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                            success(sign)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                case .failure:
                    do{
                        if let data = try? response.result.get(){
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                            failure(networkError)
                        }else{
                            failure(nil)
                        }
                    }catch{
                        print("Error while decoding \(error)")
                    }
                }
            }
        }
    
    
    //Add Task
    func profileUpdate(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.updateProfile)"
        print(url)
      //  print(param)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    //Add Task
      func phoneAdd(with param: [String:Any], success: @escaping(AddPhone) -> Void, failure: @escaping(NetworkError?) -> Void ){
          let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.addPhone)"
          print(url)
        //  print(param)
          AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
              let jsonDecoder = JSONDecoder()
              switch response.result {
              case .success:
                  if (response.response?.statusCode == 200) {
                      do{
                          let sign = try jsonDecoder.decode(AddPhone.self, from: try! response.result.get())
                          success(sign)
                      }catch{
                          print("Error while decoding \(error)")
                          do{
                              let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                              failure(networkError)
                          }catch{
                              print("Error while decoding \(error)")
                          }
                      }
                  }
                else  if (response.response?.statusCode == 500) {
                    do{
                        let sign = try jsonDecoder.decode(AddPhone.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
              case .failure:
                  do{
                      if let data = try? response.result.get(){
                          let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                          failure(networkError)
                      }else{
                          failure(nil)
                      }
                  }catch{
                      print("Error while decoding \(error)")
                  }
              }
          }
      }
    
    //Add Task
    func phoneOtp(with param: [String:Any], success: @escaping(otpModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.otpPhone)"
        print(url)
      //  print(param)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(otpModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
              else  if (response.response?.statusCode == 500) {
                    do{
                        let sign = try jsonDecoder.decode(otpModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    func deletePhone(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
        let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.deletePhone)"
        print(url)
      //  print(param)
        AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
            let jsonDecoder = JSONDecoder()
            switch response.result {
            case .success:
                if (response.response?.statusCode == 200) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
              else  if (response.response?.statusCode == 500) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
            case .failure:
                do{
                    if let data = try? response.result.get(){
                        let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                        failure(networkError)
                    }else{
                        failure(nil)
                    }
                }catch{
                    print("Error while decoding \(error)")
                }
            }
        }
    }
    
    
    //ToDoList
       func guestList(success: @escaping(GuestListModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
                    let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.guestList)"
                    print(url)
                    AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                        let jsonDecoder = JSONDecoder()
                        switch response.result {
                        case .success:
                            if (response.response?.statusCode == 200) {
                                do{
                                    let todo = try jsonDecoder.decode(GuestListModel.self, from: try! response.result.get())
                                    success(todo)
                                }catch{
                                    print("Error while decoding \(error)")
                                    do{
                                        let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                        failure(networkError)
                                    }catch{
                                        print("Error while decoding \(error)")
                                    }
                                }
                            }
                        case .failure:
                            do{
                                if let data = try? response.result.get(){
                                    let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                                    failure(networkError)
                                }else{
                                    failure(nil)
                                }
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
            }
    
    //  Blog Detail
        func guestListDetail(with param: [String:Any], success: @escaping(GuestListingData) -> Void, failure: @escaping(NetworkError?) -> Void ){
                let status = param["status"]
            let type = param["type"]
            let url = "\(GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.guestListData)status=\(status ?? 0)&type=\(type ?? "")"
                print(url)
                AF.request(url, method: .get, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                    let jsonDecoder = JSONDecoder()
                    switch response.result {
                    case .success:
                        if (response.response?.statusCode == 200) {
                            do{
                                let otpVerify = try jsonDecoder.decode(GuestListingData.self, from: try! response.result.get())
                                success(otpVerify)
                             

                            }catch{
                                print("Error while decoding \(error)")
                                do{
                                    let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                    failure(networkError)
                                }catch{
                                    print("Error while decoding \(error)")
                                }
                            }
                        }
                    case .failure:
                        do{
                            if let data = try? response.result.get(){
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                                failure(networkError)
                            }else{
                                failure(nil)
                            }
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
        }
    
    func deleteGuest(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
           //let id = param["id"]
           let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.guestDelete)"
           print(url)
           AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
               let jsonDecoder = JSONDecoder()
               switch response.result {
               case .success:
                   if (response.response?.statusCode == 200) {
                       do{
                           let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                           success(sign)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
                       if (response.response?.statusCode == 500) {
                           do{
                               let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                               success(sign)
                           }catch{
                               print("Error while decoding \(error)")
                               do{
                                   let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                   failure(networkError)
                               }catch{
                                   print("Error while decoding \(error)")
                               }
                           }
                       }
               else if (response.response?.statusCode == 401) {
                    do{
                        let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                        success(sign)
                    }catch{
                        print("Error while decoding \(error)")
                        do{
                            let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                            failure(networkError)
                        }catch{
                            print("Error while decoding \(error)")
                        }
                    }
                }
               case .failure:
                   do{
                       if let data = try? response.result.get(){
                           let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                           failure(networkError)
                       }else{
                           failure(nil)
                       }
                   }catch{
                       print("Error while decoding \(error)")
                   }
               }
           }
       }
    
    func editGuest(with param: [String:Any], success: @escaping(forgotModel) -> Void, failure: @escaping(NetworkError?) -> Void ){
              //let id = param["id"]
              let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.guestEdit)"
              print(url)
        print(param)
              AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                  let jsonDecoder = JSONDecoder()
                  switch response.result {
                  case .success:
                      if (response.response?.statusCode == 200) {
                          do{
                              let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                              success(sign)
                          }catch{
                              print("Error while decoding \(error)")
                              do{
                                  let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                  failure(networkError)
                              }catch{
                                  print("Error while decoding \(error)")
                              }
                          }
                      }
                          if (response.response?.statusCode == 500) {
                              do{
                                  let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                                  success(sign)
                              }catch{
                                  print("Error while decoding \(error)")
                                  do{
                                      let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                      failure(networkError)
                                  }catch{
                                      print("Error while decoding \(error)")
                                  }
                              }
                          }
                  else if (response.response?.statusCode == 401) {
                       do{
                           let sign = try jsonDecoder.decode(forgotModel.self, from: try! response.result.get())
                           success(sign)
                       }catch{
                           print("Error while decoding \(error)")
                           do{
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                               failure(networkError)
                           }catch{
                               print("Error while decoding \(error)")
                           }
                       }
                   }
                  case .failure:
                      do{
                          if let data = try? response.result.get(){
                              let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                              failure(networkError)
                          }else{
                              failure(nil)
                          }
                      }catch{
                          print("Error while decoding \(error)")
                      }
                  }
              }
          }
    
    func addSingleGuest(with param: [String:Any], success: @escaping(AddGuest) -> Void, failure: @escaping(NetworkError?) -> Void ){
               //let id = param["id"]
               let url = "\( GlobalConstantClass.APIConstantNames.baseUrl)\(GlobalConstantClass.APIConstantNames.addSingleGuestData)"
               print(url)
         print(param)
               AF.request(url, method: .post,parameters: param, encoding: URLEncoding.default, headers: getHeaderAfterLogin()).responseData { (response) in
                   let jsonDecoder = JSONDecoder()
                   switch response.result {
                   case .success:
                       if (response.response?.statusCode == 200) {
                           do{
                               let sign = try jsonDecoder.decode(AddGuest.self, from: try! response.result.get())
                               success(sign)
                           }catch{
                               print("Error while decoding \(error)")
                               do{
                                   let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                   failure(networkError)
                               }catch{
                                   print("Error while decoding \(error)")
                               }
                           }
                       }
                           if (response.response?.statusCode == 500) {
                               do{
                                   let sign = try jsonDecoder.decode(AddGuest.self, from: try! response.result.get())
                                   success(sign)
                               }catch{
                                   print("Error while decoding \(error)")
                                   do{
                                       let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                       failure(networkError)
                                   }catch{
                                       print("Error while decoding \(error)")
                                   }
                               }
                           }
                   else if (response.response?.statusCode == 401) {
                        do{
                            let sign = try jsonDecoder.decode(AddGuest.self, from: try! response.result.get())
                            success(sign)
                        }catch{
                            print("Error while decoding \(error)")
                            do{
                                let networkError = try jsonDecoder.decode(NetworkError.self, from: try! response.result.get())
                                failure(networkError)
                            }catch{
                                print("Error while decoding \(error)")
                            }
                        }
                    }
                   case .failure:
                       do{
                           if let data = try? response.result.get(){
                               let networkError = try jsonDecoder.decode(NetworkError.self, from: data)
                               failure(networkError)
                           }else{
                               failure(nil)
                           }
                       }catch{
                           print("Error while decoding \(error)")
                       }
                   }
               }
           }
 
}
