//
//  NetResClientConfig.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 04/02/25.
//

import Foundation

struct NetResAppConfig: NetResBody {
    let mapType: String?
    let setting: Setting?
    let twoGisKey: String?

    enum CodingKeys: String, CodingKey {
        case mapType = "map_type"
        case setting
        case twoGisKey = "two_gis_key"
    }
    
    struct Setting: Codable {
        let executorLink: String?
        let facebook: String?
        let instagram: String?
        let inviteLinkForFriend: String?
        let paymentType: [String]?
        let privacyPolicyRu: String?
        let privacyPolicyUz: String?
        let supportEmail: String?
        let supportInstagramNickname: String?
        let supportPhone: String?
        let supportTelegramNickname: String?
        let telegramNickname: String?
        let textAboutAppRu: String?
        let textAboutAppUz: String?
        let textForNotServeThisRegionRu: String?
        let textForNotServeThisRegionUz: String?
        let youtube: String?

        enum CodingKeys: String, CodingKey {
            case executorLink = "executor_link"
            case facebook
            case instagram
            case inviteLinkForFriend = "invite_link_for_friend"
            case paymentType = "payment_type"
            case privacyPolicyRu = "privacy_policy_ru"
            case privacyPolicyUz = "privacy_policy_uz"
            case supportEmail = "support_email"
            case supportInstagramNickname = "support_instagram_nickname"
            case supportPhone = "support_phone"
            case supportTelegramNickname = "support_telegram_nickname"
            case telegramNickname = "telegram_nickname"
            case textAboutAppRu = "text_about_app_ru"
            case textAboutAppUz = "text_about_app_uz"
            case textForNotServeThisRegionRu = "text_for_not_serve_this_region_ru"
            case textForNotServeThisRegionUz = "text_for_not_serve_this_region_uz"
            case youtube
        }
    }
}
