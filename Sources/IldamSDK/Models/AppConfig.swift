//
//  AppConfig.swift
//  Ildam
//
//  Created by Muhammadjon Tohirov on 04/02/25.
//

import Foundation

public struct AppConfig: Codable {
    public let mapType: String?
    public let setting: Setting?
    public let twoGisKey: String?
    
    public struct Setting: Codable {
        public let executorLink: String?
        public let facebook: String?
        public let instagram: String?
        public let inviteLinkForFriend: String?
        public let paymentType: [String]?
        public let privacyPolicyRu: String?
        public let privacyPolicyUz: String?
        public let supportEmail: String?
        public let supportInstagramNickname: String?
        public let supportPhone: String?
        public let supportTelegramNickname: String?
        public let telegramNickname: String?
        public let textAboutAppRu: String?
        public let textAboutAppUz: String?
        public let textForNotServeThisRegionRu: String?
        public let textForNotServeThisRegionUz: String?
        public let youtube: String?
        
        public init(executorLink: String?, facebook: String?, instagram: String?, inviteLinkForFriend: String?, paymentType: [String]?, privacyPolicyRu: String?, privacyPolicyUz: String?, supportEmail: String?, supportInstagramNickname: String?, supportPhone: String?, supportTelegramNickname: String?, telegramNickname: String?, textAboutAppRu: String?, textAboutAppUz: String?, textForNotServeThisRegionRu: String?, textForNotServeThisRegionUz: String?, youtube: String?) {
            self.executorLink = executorLink
            self.facebook = facebook
            self.instagram = instagram
            self.inviteLinkForFriend = inviteLinkForFriend
            self.paymentType = paymentType
            self.privacyPolicyRu = privacyPolicyRu
            self.privacyPolicyUz = privacyPolicyUz
            self.supportEmail = supportEmail
            self.supportInstagramNickname = supportInstagramNickname
            self.supportPhone = supportPhone
            self.supportTelegramNickname = supportTelegramNickname
            self.telegramNickname = telegramNickname
            self.textAboutAppRu = textAboutAppRu
            self.textAboutAppUz = textAboutAppUz
            self.textForNotServeThisRegionRu = textForNotServeThisRegionRu
            self.textForNotServeThisRegionUz = textForNotServeThisRegionUz
            self.youtube = youtube
        }
    }
    
    public init(mapType: String?, setting: Setting?, twoGisKey: String?) {
        self.mapType = mapType
        self.setting = setting
        self.twoGisKey = twoGisKey
    }
}

extension AppConfig {
    init(_ config: NetResAppConfig) {
        self.init(
            mapType: config.mapType,
            setting: .init(config.setting),
            twoGisKey: config.twoGisKey
        )
    }
}

extension AppConfig.Setting {
    init?(_ config: NetResAppConfig.Setting?) {
        guard let config else { return nil }
        
        self.executorLink = config.executorLink
        self.facebook = config.facebook
        self.instagram = config.instagram
        self.inviteLinkForFriend = config.inviteLinkForFriend
        self.paymentType = config.paymentType
        self.privacyPolicyRu = config.privacyPolicyRu
        self.privacyPolicyUz = config.privacyPolicyUz
        self.supportEmail = config.supportEmail
        self.supportInstagramNickname = config.supportInstagramNickname
        self.supportPhone = config.supportPhone
        self.supportTelegramNickname = config.supportTelegramNickname
        self.telegramNickname = config.telegramNickname
        self.textAboutAppRu = config.textAboutAppRu
        self.textAboutAppUz = config.textAboutAppUz
        self.textForNotServeThisRegionRu = config.textForNotServeThisRegionRu
        self.textForNotServeThisRegionUz = config.textForNotServeThisRegionUz
        self.youtube = config.youtube
    }
}

public extension AppConfig {
    var isGoogleMap: Bool {
        mapType == "google"
    }
    
    var hasFacebook: Bool {
        setting?.facebook != nil
    }
    
    var hasInstagram: Bool {
        setting?.instagram != nil
    }
    
    var hasYoutube: Bool {
        setting?.youtube != nil
    }
    
    var hasPhone: Bool {
        setting?.supportPhone != nil
    }
    
    var hasTelegram: Bool {
        setting?.supportTelegramNickname != nil
    }
    
    func inviteLinkForFriend(phone: String) -> String? {
        return setting?.inviteLinkForFriend
    }
    
    var isCashPaymentEnabled: Bool {
        setting?.paymentType?.contains("cash") ?? false
    }
    
    var isCardPaymentEnabled: Bool {
        setting?.paymentType?.contains("card") ?? false
    }
    
    var becomeDriverLink: String? {
        self.setting?.executorLink
    }
}
