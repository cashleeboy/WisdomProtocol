//
//  WisdomProtocolRight.swift
//  WisdomProtocolRight
//
//  Created by 汤建锋 on 2022/11/22.
//

import WisdomProtocol


public let RightVCProtocol: Protocol = {
    return WisdomProtocol.registerable(classable: WisdomClassable(register: WisdomProtocolRightProtocol.self, conform: WisdomProtocolRightVC.self))
}()

public let RightImageProtocol: Protocol = RightImageable.self

// Image Protocol
@objc protocol RightImageable {}
