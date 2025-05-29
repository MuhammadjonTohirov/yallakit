//
//  OrderChannels.swift
//  YallaKit
//
//  Created by MuhammadAli on 27/05/25.
//

import Foundation

public enum WebSocketOrderChannels: String {
    case ordersMe                             = "orders-me" // DNetActiveOrderListResponse
    case me                                   = "me" // DNetExecutorMeResponse
    case info                                 = "info" // DNetExecutorMeResponse
    
    case ordersEther                          = "orders-ether" // DNetResEtherResponse
    case orderSendToEther                     = "order-send-to-ether" // DNetOrderSentToEtherResult
    case orderSendToExecutorFromNonstop       = "order-send-to-executor-from-nonstop" // DNetOrderSentToExecutorResult
    case orderSendToExecutor                  = "order-send-to-executor" // DNetOrderSentToExecutorResult
    case orderAppointToExecutor               = "order-appoint-to-executor" // DNetOrderSentToExecutorResult
    
    case orderRemoveFromEther                 = "order-remove-from-ether" //  DNetOrderRemoveFromAppointedExecutor ✅
    case orderRemoveFromExecutor              = "order-remove-from-executor" // DNetOrderRemoveFromAppointedExecutor ✅
    case orderRemoveFromAppointedExecutor     = "order-remove-from-appointed-executor" // DNetOrderRemoveFromAppointedExecutor ✅
    
    case orderUpdate                          = "order-update" // DNetOrderUpdateResult
    case orderUpdateFromEther                 = "order-update-from-ether" // DNetOrderSentToEtherResult

    case orderShow                            = "order-show" // DNetOrderShowResponse
    case orderSkip                            = "order-skip"// TODO: [Info] useless
    case orderAppointFromOffer                = "order-appoint-from-offer" // DNetOrderAppointResult
    case orderAppoint                         = "order-appoint" // DNetOrderAppointResult
    
    case orderCompletedFromPanel              = "order-completed-from-panel" // DNetOrderCompletedFromPanel ✅
    case orderComplete                        = "order-complete"//DNetOrderCompletedFromPanel✅
    
    case statusUpdateFromPanel                = "status-update-from-panel" //DNetOrderStatusUpdateFromPanelResult ✅
    case orderStatusUpdate                    = "order/status/update" // DNetOrderStatusUpdateFromPanelResult ✅
    
    case orderCanceledFromClient              = "order-canceled-from-client" // DNetOrderCanceledFromPanel ✅
    case orderCanceledFromPanel               = "order-canceled-from-panel" // DNetOrderCanceledFromPanel ✅
    case orderCancel                          = "order-cancel" // DNetOrderCanceledFromPanel ✅
    
    case tariffConfigs                        = "tariff-configs" // DNetOrderTariffConfigResponse
    case curbDefault                          = "curb-default" // DNetDefaultTariffResult
    case curbCreate                           = "curb-create" // DNetCrubOrderResponse
    
    case balanceIncome                        = "balance_income" // DNetExecutorMeResponse
    case balanceExpense                       = "balance_expense" // DNetExecutorMeResponse
    case balance                              = "balance" // DNetExecutorMeResponse
    
    case fotocontrol                          = "fotocontrol" // DNetExecutorMeResponse
    case getCondition                         = "get-condition" // DNetGetConditionResponse
    case condition                            = "condition" // DNetGetConditionResponse
    case panelCondition                       = "panel_condition" // DNetGetConditionResponse
}
