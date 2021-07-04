//
//  Defaults + Extension.swift
//  WedAdvisor
//
//  Created by Vivek Singh Mehta on 20/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import DefaultsKit
import Foundation


extension DefaultsKey {
    
    ///To check if the user have logged in or not
    static let isLoggedIn = Key<Bool>("isLoggedIn")
    
    /// false when app is launched for the first time, true when we don't have to show onboarding screen.
    static let firstTimeOver = Key<Bool>("firstTimeOver")
    
    ///profile model in defaults
    static let profile = Key<MyProfileModel>("profile")
    
    static let location = Key<HomeLocation>("location")
    
}
