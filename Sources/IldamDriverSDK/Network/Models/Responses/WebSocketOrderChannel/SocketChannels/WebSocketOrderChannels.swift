//
//  OrderChannels.swift
//  YallaKit
//
//  Created by MuhammadAli on 27/05/25.
//

import Foundation

enum WebSocketOrderChannels: String {
    case ordersMe                             = "orders-me" // DNetActiveOrderListResponse
    case me                                   = "me" // DNetExecutorMeResponse
    case info                                 = "info" // DNetExecutorMeResponse
    
    case ordersEther                          = "orders-ether" // DNetResEtherResponse
    case orderSendToEther                     = "order-send-to-ether" // DNetOrderSentToEtherResult
    case orderUpdateFromEther                 = "order-update-from-ether" // DNetOrderSentToEtherResult
    case orderSendToExecutorFromNonstop       = "order-send-to-executor-from-nonstop" // DNetOrderSentToExecutorResult
    case orderSendToExecutor                  = "order-send-to-executor" // DNetOrderSentToExecutorResult
    case orderAppointToExecutor               = "order-appoint-to-executor" // DNetOrderSentToExecutorResult
    
    case orderRemoveFromEther                 = "order-remove-from-ether" //  DNetOrderRemoveFromAppointedExecutor
    case orderRemoveFromExecutor              = "order-remove-from-executor" // DNetOrderRemoveFromAppointedExecutor
    case orderRemoveFromAppointedExecutor     = "order-remove-from-appointed-executor" // DNetOrderRemoveFromAppointedExecutor
    
    case orderUpdate                          = "order-update" // DNetOrderUpdateResult
    case orderShow                            = "order-show" // DNetOrderShowResponse
    case orderSkip                            = "order-skip"
    case orderAppointFromOffer                = "order-appoint-from-offer"
    case orderAppoint                         = "order-appoint"
    case orderCompletedFromPanel              = "order-completed-from-panel"
    case orderComplete                        = "order-complete"
    case statusUpdateFromPanel                = "status-update-from-panel" //DNetOrderStatusUpdateFromPanelResult
    case orderStatusUpdate                    = "order/status/update" // DNetOrderStatusUpdateFromPanelResult
    
    case orderCanceledFromClient              = "order-canceled-from-client" // DNetOrderCanceledFromPanel
    case orderCanceledFromPanel               = "order-canceled-from-panel" // DNetOrderCanceledFromPanel
    case orderCancel                          = "order-cancel" // DNetOrderCanceledFromPanel
    
    case tariffConfigs                        = "tariff-configs" // DNetOrderTariffConfigResponse
    case curbDefault                          = "curb-default" // DNetDefaultTariffResult
    case curbCreate                           = "curb-create" // DNetCrubOrderResponse
    case balanceIncome                        = "balance_income"
    case balanceExpense                       = "balance_expense"
    case balance                              = "balance"
    case fotocontrol                          = "fotocontrol"
    case getCondition                         = "get-condition" // DNetGetConditionResponse
    case condition                            = "condition" // DNetGetConditionResponse
    case panelCondition                       = "panel_condition" // DNetGetConditionResponse
}
