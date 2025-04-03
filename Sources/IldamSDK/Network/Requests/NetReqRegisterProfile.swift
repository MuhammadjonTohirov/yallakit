//
//  NetReqRegisterProfile.swift
//  Ildam
//
//  Created by applebro on 07/12/23.
//

import Foundation
import Core

struct NetReqRegisterProfile: Codable {
    var phone: String
    var givenNames: String
    var surname: String
    var gender: Gender
    var birthday: String? // day.month.year
    var key: String
    
    enum CodingKeys: String, CodingKey {
        case phone
        case givenNames = "given_names"
        case surname = "sur_name"
        case gender
        case birthday
        case key
    }
    
    init(phone: String, givenNames: String, surname: String, gender: Gender, birthday: String, key: String) {
        self.phone = phone
        self.givenNames = givenNames
        self.surname = surname
        self.gender = gender
        self.birthday = birthday.nilIfEmpty
        self.key = key
    }
    
    mutating func set(birthDate date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        self.birthday = formatter.string(from: date)
    }
}
