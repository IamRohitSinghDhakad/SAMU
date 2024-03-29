//
//  WebServiceHelper.swift
//  Somi
//
//  Created by Paras on 24/03/21.
//

import Foundation
import UIKit


let BASE_URL = "https://ambitious.in.net/Arun/samu/index.php/api/"//Local

struct WsUrl{
    static let url_Login  = BASE_URL + "login"
    static let url_SignUp  = BASE_URL + "signup"
    static let url_GetBanner  = BASE_URL + "get_banner"
    static let url_GetCategory = BASE_URL + "get_category"
    static let url_GetProfile = BASE_URL + "get_profile"
    static let url_getChatList = BASE_URL + "get_chat"
    static let url_insertChat = BASE_URL + "insert_chat"
    static let url_deleteChatSingleMessage = BASE_URL + "delete_message"
    static let url_Logout = BASE_URL + "logout"
}

struct WsParamsType {
    static let PathVariable = "Path Variable"
    static let QueryParams = "Query Params"
}

//Api Header

struct WsHeader {

    //Login

    static let deviceId = "Device-Id"

    static let deviceType = "Device-Type"

    static let deviceTimeZone = "Device-Timezone"

    static let ContentType = "Content-Type"

}

/*

//Api parameters

struct WsParam {

    

    //static let itunesSharedSecret : String = "c736cf14764344a5913c8c1"

    //Signup

    static let dialCode = "dialCode"

    static let contactNumber = "contactNumber"

    static let code = "code"

    static let deviceToken = "deviceToken"

    static let deviceType = "deviceType"

    static let firstName = "firstName"

    static let lastName = "lastName"

    static let email = "email"

    static let driverImage = "driverImage"

    static let isSignup = "isSignup"

    static let licenceImage = "licenceImage"

    static let socialId = "socialId"

    static let socialType = "socialType"

    static let imageUrl = "image_url"

    static let invitationId = "invitationId"

    static let status = "status"

    static let companyId = "companyId"

    static let vehicleId = "vehicleId"

    static let type = "type"

    static let bookingId = "bookingId"

    static let location = "location"

    static let latitude = "latitude"

    static let longitude = "longitude"

    static let currentdate_time = "current_date_time"

}

*/
