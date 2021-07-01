//
//  GlobalConstant.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 27/02/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import Foundation
import UIKit
class GlobalConstantClass: NSObject {
    static let sharedInstance = GlobalConstantClass()
   // @available(iOS 13.0, *)
    struct APIConstantNames {
        static let appDelegate = UIApplication.shared.delegate as! AppDelegate
        static let baseUrl = "https://wed-advisor.com"
        static let filter = "https://wed-advisor.com/find-vendor"
        static let imageBaseURL = "https://wed-advisor.com/images/"
        static let vendorDetail = "/list-single/"
        static let filtervendor = "/find-vendor?vendor_type="
        static let bloglist = "/blog-listing"
        static let signup = "/api/auth/register"
        static let login = "/api/auth/login"
        static let gallery = "/gallery?page="
        static let forgot = "/api/auth/forgot-password"
        static let dashboard = "/api/couple-dashboard"
        static let myWishList = "/api/couple-wishlist"
        static let removeWishList = "/api/remove-from-wishlist"
        static let addWishList = "/api/useraddtowishlist"
        static let myProfile = "/api/couple-profile"
        static let changePassword = "/api/userchangepassword"
        static let blogdetail = "/blog-single/"
        static let todocount = "/api/app-todolist-count"
        static let todocountListing = "/api/app-todolist"
        static let todiaddTask = "/api/couple-todolist"
        static let deleteTask = "/api/todolistdelete"
        static let editTask = "/api/edittodolist"
        static let updateProfile = "/api/userprofileupdate"
        static let addPhone = "/api/useraddnumber"
        static let otpPhone = "/api/userverifyotp"
        static let deletePhone = "/api/usermobiledeletedata"
        static let guestList = "/api/couple-guests"
        static let guestListData = "/api/guestsdetails?"
        static let guestDelete = "/api/deleteguest"
        static let guestEdit = "/api/updateguest"
        static let addSingleGuestData = "/api/add-new-guest"
    }
    
    @available(iOS 13.0, *)
    struct Constant {
        static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
    
    /// All alert constant
    struct Alert {
        static let NoNetwork = "No Internet Available!"
        static let emptyEmail = "Please enter your email"
        static let wrongEmail = "Email is not correct!"
        static let emptyPassword = "Please enter your password"
        static let emptyOldPassword = "Please enter your old password"
        static let emptyNewPassword = "Please enter new password"
        static let wrongPasswordLength = "Password must be minimum 8 characters"
        static let emptyConfirmPassword = "Please enter confirm password"
        static let wrongConfirmPassword = "Confirm password does not macthed!"
        static let wroneNewPassword = "New password should not be same as previous"
        static let emptyFirstName = "Please enter first name"
        static let emptyName = "Please enter name"
        static let emptyLastName = "Please enter last name"
        static let emptyMobile = "Please enter your mobile number"
        static let wrongMobileLength = "Enter correct mobile number"
        static let emptyImage  = "Please upload image"
        static let selectCountry = "Please select country"
        static let selectCity = "Please select city"
        static let emptyAddress = "Please enter your address"
        static let emptyGeoLocation = "Please select your geo location"
        static let emptyIssue = "Please select an issue"
        static let emptyTitle = "Please enter title"
        static let emptyDesc = "Please enter description"
        static let emptyImages = "Please upload atleast one image"
        
        static let referCode = "Please enter Refferal Code"
        static let emptyOtp = "Please input otp value"
        static let otpMsgVerify = "Otp does't match"
        static let subject = "Please enter Subject"
        static let comment = "Please enter Comment"
        static let gender = "Please select gender"
        static let country = "Please select Country"
        static let emptyimage = "Please select Image"
        
    }
    
    
    struct KeyConstants {
        static let userId = "userId"
        static let device_id = "device_id"
        static let email = "email"
        static let mobile = "mobile"
        static let country_code = "country_code"
        static let password = "password"
        static let deviceIDRest = "device_id"
        static let first_name = "first_name"
        static let last_name = "last_name"
        static let sessionToken = "sessionToken"
        static let referral_code = "referral_code"
        static let Gender = "Gender"
        static let Profile_pic = "Profile_pic"
        static let accessToken = "access-token"
    }
}
