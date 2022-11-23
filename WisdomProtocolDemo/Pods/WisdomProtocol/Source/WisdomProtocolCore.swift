//
//  WisdomProtocolCore.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

struct WisdomProtocolCore {
    
    private static var WisdomProtocolConfig: [String:AnyClass] = [:]

    private static var WisdomRegisterState: Int = 0
    
    // MARK: registerProtocol protocol class
    private static func registerableConfig(register Protocol: Protocol, conform Class: AnyClass)->Protocol {
        let key = NSStringFromProtocol(Protocol)
        if !class_conformsToProtocol(Class, Protocol) {
            print("❌[WisdomProtocol] register no conforming: "+key+"->"+NSStringFromClass(Class)+"❌")
            return Protocol
        }
        if WisdomProtocolConfig[key] != nil {
            print("❌[WisdomProtocol] register redo conforming: "+key+"->"+NSStringFromClass(Class)+"❌")
            return Protocol
        }
        WisdomProtocolConfig.updateValue(Class, forKey: key)
        print("✅[WisdomProtocol] register successful: "+key+"->"+NSStringFromClass(Class)+"✅")
        return Protocol
    }
}

extension WisdomProtocolCore: WisdomProtocolRegisterable{
    
    static func registerable() {
        if WisdomProtocolCore.WisdomRegisterState == 1 {
            return
        }
        WisdomProtocolCore.WisdomRegisterState = 1
        
        let start = CFAbsoluteTimeGetCurrent()
        let protocolQueue = DispatchQueue(label: "WisdomProtocolCoreQueue", attributes: DispatchQueue.Attributes.concurrent)

        let c = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: c)
        let autoTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoTypes, Int32(c))
        
        //let list: [Int:Int] = [0: c/5, c/5+1: c/5*2, c/5*2+1: c/5*3, c/5*3+1: c/5*4, c/5*4+1: c]
        let list: [Int:Int] = [0: c/4, c/4+1: c/2, c/2+1: c/4*3, c/4*3+1: c]
        //let list: [Int:Int] = [0: c/3, c/3+1: c/3*2, c/3*2+1: c]
        //let list: [Int:Int] = [0: c/2, c/2+1: c]
        for index in list { regist(types: types, begin: index.key, end: index.value) }
        
        func regist(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
            protocolQueue.async {
                for index in begin ..< end {
                    if class_conformsToProtocol(types[index], WisdomRegisterable.self) {
                        if let ableClass = (types[index] as? WisdomRegisterable.Type)?.registerable() {
                            _=registerableConfig(register: ableClass.registerProtocol, conform: ableClass.conformClass)
                        }
                    }
                }
            }
        }
        
        protocolQueue.sync(flags: .barrier) {
            types.deallocate()
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("WisdomProtocolCore Queue Took " + "\(diff)")
        }
    }
    
    static func registerable(classable: WisdomClassable)->Protocol{
        return registerableConfig(register: classable.registerProtocol, conform: classable.conformClass)
    }
    
    //static func registerable(classables: [WisdomClassable])->[Protocol]{
    //    let protocols = classables.compactMap { classable in
    //        registerableConfig(register: classable.registerProtocol, conform: classable.conformClass)
    //    }
    //    return protocols
    //}
}

extension WisdomProtocolCore: WisdomProtocolCreateable{
    
    static func create(protocolName: String) -> Protocol? {
        return NSProtocolFromString(protocolName)
    }
    
    static func create(projectName: String, protocolName: String) -> Protocol? {
        let name = projectName+"."+protocolName
        return NSProtocolFromString(name)
    }
}

extension WisdomProtocolCore: WisdomProtocolable {
    
    static func getClassable(from Protocol: Protocol)->AnyClass? {
        let protocolKey = NSStringFromProtocol(Protocol)
        print("WisdomProtocol.getClassable: "+protocolKey)

        if let conformClass: AnyClass = WisdomProtocolConfig[protocolKey], conformClass.conforms(to: Protocol) {
            return conformClass
        }
        return nil
    }
    
    static func getViewable(from Protocol: Protocol)->UIView.Type? {
        if let conformClass = getClassable(from: Protocol), let conformView = conformClass as? UIView.Type {
            return conformView
        }
        return nil
    }
    
    static func getControlable(from Protocol: Protocol)->UIViewController.Type? {
        if let conformClass = getClassable(from: Protocol), let conformController = conformClass as? UIViewController.Type {
            return conformController
        }
        return nil
    }
}

extension WisdomProtocolCore: WisdomProtocolRouterable{
    
    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?{
        if let classable = Self.getClassable(from: Protocol), classable.conforms(to: WisdomRouterClassable.self),
           let paramable = classable as? WisdomRouterClassable.Type {
            return paramable
        }
        return nil
    }

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?{
        if let classable = Self.getViewable(from: Protocol), classable.conforms(to: WisdomRouterViewable.self),
           let viewable = classable as? WisdomRouterViewable.Type {
            return viewable
        }
        return nil
    }

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?{
        if let classable = Self.getControlable(from: Protocol), classable.conforms(to: WisdomRouterControlable.self),
           let controlable = classable as? WisdomRouterControlable.Type {
            return controlable
        }
        return nil
    }
}
