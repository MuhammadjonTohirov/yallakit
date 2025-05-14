//
//  DNetOrderCancelResponse.swift
//  YallaKit
//
//  Created by MuhammadAli on 29/04/25.
//


import Foundation
import NetworkLayer

struct DNetOrderCancelResult: DNetResBody {
    let id: Int
    let status: String
}
