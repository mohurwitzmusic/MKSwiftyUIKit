import UIKit
import Combine

public struct UIControlPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never
    
    private let control: Control
    private let event: UIControl.Event
    
    public init(control: Control, event: UIControl.Event) {
        self.control = control
        self.event = event
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Control == S.Input {
        let subscription = Subscription(subscriber: subscriber, control: control, event: event)
        subscriber.receive(subscription: subscription)
    }
}


extension UIControlPublisher {
    
    public final class Subscription<S: Subscriber>: Combine.Subscription where S.Input == Control, S.Failure == Failure {
        private var subscriber: S?
        private let control: Control
        private var demand: Subscribers.Demand?
        
        
        public init(subscriber: S, control: Control, event: UIControl.Event) {
            Swift.print("Init")
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        @objc private func handleEvent() {
            guard let subscriber, let demand, demand > 0 else { return }
            let newDemand = subscriber.receive(control)
            self.demand = demand + newDemand
        }
        
        public func cancel() {
            subscriber = nil
        }
        
        public func request(_ demand: Subscribers.Demand) {
            self.demand = demand
        }
    }
    
}


public protocol UIControlPublishable { }

public extension UIControlPublishable where Self : UIControl {
    func publisher(for event: UIControl.Event) -> UIControlPublisher<Self> {
        UIControlPublisher(control: self, event: event)
    }
}

extension UIControl : UIControlPublishable { }
