//
//  File.swift
//  YallaKit
//
//  Created by applebro on 30/05/25.
//

import Foundation

public protocol WebSocketChannelHandler: AnyObject, Sendable {
    func onReceiveOrdersMe(_ response: ActiveOrderListResponse)
    func onReceiveMe(_ response: ExecutorMeResponse)
    func onReceiveInfo(_ response: ExecutorMeResponse)
    
    func onReceiveOrdersEther(_ response: OrderListResponse)
    func onReceiveOrderSendToEther(_ response: [OrderSentToExecutorResponse])
    func onReceiveOrderSendToExecutorFromNonStop(_ response: OrderSentToExecutorResponse )
    func onReceiveOrderSendToExecutor(_ response: OrderSentToExecutorResponse)
    func onReceiveOrderAppointToExecutor(_ response: OrderSentToExecutorResponse)
    
    func onReceiveOrderRemoveFromEther(_ response: OrderRemoveFromAppointedExecutorResponse)
    func onReceiveOrderRemoveFromExecutor(_ response:OrderRemoveFromAppointedExecutorResponse)
    func onReceiveOrderRemoveFromAppointedExecutor(_ response:OrderRemoveFromAppointedExecutorResponse)

    func onReceiveOrderUpdate(_ response: OrderUpdateSocketResponse)
    func onReceiveOrderUpdateFromEther(_ response: OrderSentToEtherResponse)

    func onReceiveStatusUpdateFromPanel(_ response: OrderStatusUpdateFromPanelResponse)
    func onReceiveOrderStatusUpdate(_ response: OrderStatusUpdateFromPanelResponse)

    func onReceiveOrderShow(_ response: OrderShowResponse)
    func onReceiveOrderSkip()
    
    func onReceiveOrderAppointFromOffer(_ response: OrderAppointedResponse)
    func onReceiveOrderAppoint(_ response: OrderAppointedResponse)
    
    func onReceiveOrderCompletedFromPanel(_ response: OrderCompletedFromPanel)
    func onReceiveOrderComplete(_ response: OrderCompletedFromPanel)
    
    func onReceiveOrderCanceledFromClient(_ response: OrderCanceledFromPanelResponse)
    func onReceiveOrderCanceledFromPanel(_ response: OrderCanceledFromPanelResponse)
    func onReceiveOrderCancel(_ response: OrderCanceledFromPanelResponse)
    
    func onReceiveTariffConfigs(_ response: OrderTariffConfigurationResponse)
    
    func onReceiveCurbDefault(_ response: DriverDefaultTariffResponse)
    func onReceiveCurbCreate(_ response:  DriverCrubResponse)
    
    func onReceiveBalanceIncome(_ response: ExecutorMeResponse)
    func onReceiveBalanceExpense(_ response: ExecutorMeResponse)
    func onReceiveBalance(_ response: ExecutorMeResponse)
    
    func onReceiveFotocontrol(_ response: ExecutorMeResponse)
    
    func onReceiveGetCondition(_ response: DriverGetConditionResponse)
    func onReceiveCondition(_ response:DriverGetConditionResponse)
    func onReceivePanelCondition(_ response:DriverGetConditionResponse)
}

public extension WebSocketChannelHandler {
    func onReceiveOrdersMe(_ response: ActiveOrderListResponse) {}
    func onReceiveMe(_ response: ExecutorMeResponse) {}
    func onReceiveInfo(_ response: ExecutorMeResponse) {}
    
    func onReceiveOrdersEther(_ response: OrderListResponse) {}
    func onReceiveOrderSendToEther(_ response: [OrderSentToExecutorResponse]) {}
    func onReceiveOrderSendToExecutorFromNonStop(_ response: OrderSentToExecutorResponse ) {}
    func onReceiveOrderSendToExecutor(_ response: OrderSentToExecutorResponse) {}
    func onReceiveOrderAppointToExecutor(_ response: OrderSentToExecutorResponse) {}
    
    func onReceiveOrderRemoveFromEther(_ response: OrderRemoveFromAppointedExecutorResponse) {}
    func onReceiveOrderRemoveFromExecutor(_ response:OrderRemoveFromAppointedExecutorResponse) {}
    func onReceiveOrderRemoveFromAppointedExecutor(_ response:OrderRemoveFromAppointedExecutorResponse) {}

    func onReceiveOrderUpdate(_ response: OrderUpdateSocketResponse) {}
    func onReceiveOrderUpdateFromEther(_ response: OrderSentToEtherResponse) {}

    func onReceiveStatusUpdateFromPanel(_ response: OrderStatusUpdateFromPanelResponse) {}
    func onReceiveOrderStatusUpdate(_ response: OrderStatusUpdateFromPanelResponse) {}

    func onReceiveOrderShow(_ response: OrderShowResponse) {}
    func onReceiveOrderSkip() {}
    
    func onReceiveOrderAppointFromOffer(_ response: OrderAppointedResponse) {}
    func onReceiveOrderAppoint(_ response: OrderAppointedResponse) {}
    
    func onReceiveOrderCompletedFromPanel(_ response: OrderCompletedFromPanel) {}
    func onReceiveOrderComplete(_ response: OrderCompletedFromPanel) {}
    
    func onReceiveOrderCanceledFromClient(_ response: OrderCanceledFromPanelResponse) {}
    func onReceiveOrderCanceledFromPanel(_ response: OrderCanceledFromPanelResponse) {}
    func onReceiveOrderCancel(_ response: OrderCanceledFromPanelResponse) {}
    
    func onReceiveTariffConfigs(_ response: OrderTariffConfigurationResponse) {}
    
    func onReceiveCurbDefault(_ response: DriverDefaultTariffResponse) {}
    func onReceiveCurbCreate(_ response:  DriverCrubResponse) {}
    
    func onReceiveBalanceIncome(_ response: ExecutorMeResponse) {}
    func onReceiveBalanceExpense(_ response: ExecutorMeResponse) {}
    func onReceiveBalance(_ response: ExecutorMeResponse) {}
    
    func onReceiveFotocontrol(_ response: ExecutorMeResponse) {}
    
    func onReceiveGetCondition(_ response: DriverGetConditionResponse) {}
    func onReceiveCondition(_ response:DriverGetConditionResponse) {}
    func onReceivePanelCondition(_ response:DriverGetConditionResponse) {}
}
