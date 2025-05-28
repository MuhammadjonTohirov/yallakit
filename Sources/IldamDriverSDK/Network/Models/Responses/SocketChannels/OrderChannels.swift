//
//  OrderChannels.swift
//  YallaKit
//
//  Created by MuhammadAli on 27/05/25.
//

import Foundation

enum OrderChannels: String {
    case ordersMe                             = "orders-me" // DNetActiveOrderListResponse ✅
    case me                                   = "me" // DNetExecutorMeResponse ✅
    case info                                 = "info" //
    case ordersEther                          = "orders-ether" // DNetResEtherResponse ✅
    case orderSendToEther                     = "order-send-to-ether"
    case orderUpdateFromEther                 = "order-update-from-ether"
    case orderSendToExecutorFromNonstop       = "order-send-to-executor-from-nonstop" //
    case orderSendToExecutor                  = "order-send-to-executor"
    case orderAppointToExecutor               = "order-appoint-to-executor"
    case orderRemoveFromEther                 = "order-remove-from-ether"
    case orderRemoveFromExecutor              = "order-remove-from-executor"
    case orderRemoveFromAppointedExecutor     = "order-remove-from-appointed-executor"
    case orderUpdate                          = "order-update"
    case orderShow                            = "order-show" // DNetOrderShowResponse
    case orderSkip                            = "order-skip"
    case orderAppointFromOffer                = "order-appoint-from-offer"
    case orderAppoint                         = "order-appoint"
    case orderCompletedFromPanel              = "order-completed-from-panel"
    case orderComplete                        = "order-complete"
    case statusUpdateFromPanel                = "status-update-from-panel"
    case orderStatusUpdate                    = "order/status/update"
    case orderCanceledFromClient              = "order-canceled-from-client"
    case orderCanceledFromPanel               = "order-canceled-from-panel"
    case orderCancel                          = "order-cancel"
    case tariffConfigs                        = "tariff-configs" // DNetOrderTariffConfigResponse
    case curbDefault                          = "curb-default" // DNetDefaultTariffResult
    case curbCreate                           = "curb-create" // DNetCrubOrderResponse
    case balanceIncome                        = "balance_income"
    case balanceExpense                       = "balance_expense"
    case balance                              = "balance"
    case fotocontrol                          = "fotocontrol"
    case getCondition                         = "get-condition" // DNetGetConditionResponse
    case condition                            = "condition" // DNetGetConditionResponse
    case panelCondition                       = "panel_condition"
}
