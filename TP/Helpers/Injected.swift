//
//  Injected.swift
//  TP
//
//  Created by Developer on 23.11.2022.
//

import Foundation

protocol Injectable {
    init()
}

@propertyWrapper
class Inject<T: Injectable> {
    private var container = DependencyContainer.shared
    
    var wrappedValue: T {
        get {
            if let resolved = container.resolve(T.self) {
                return resolved
            } else {
                let defaultValue = T()
                container.register(defaultValue)
                return defaultValue
            }
        }
        set { container.register(newValue) }
    }
}

private class DependencyContainer {
    static let shared = DependencyContainer()
    
    private static var dependencies: [String: Any] = [:]
    
    func register<T>(_ value: T) {
        DependencyContainer.dependencies[String(describing: T.self)] = value
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return DependencyContainer.dependencies[String(describing: type)] as? T
    }
}
