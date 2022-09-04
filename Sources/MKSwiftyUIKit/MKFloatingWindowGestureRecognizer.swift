
import UIKit
import UIKit.UIGestureRecognizerSubclass

/// A `UIGestureRecognizer` subclass that can be added to a `UIView` to support
/// moving and resizing. It can be added to a `UINavigationBar` to create a
/// floating window that behaves similar to a typical macOS window.
///
/// The recognizer supports two gestures: *pan*, and *pinch*.
///
/// You can query the recognizer's `gesture` property to find out which is the current gesture.
///
/// The `gesture` property is a FSM that transitions between 3 states:
/// `.none` -->  `.pan` --> `pinch`
///
/// 1. **none**. No pan or pinch gesture was recognized.
/// 2. **pan**. When the user places a single finger down, the gesture recognizer enters the `.pan` state and the view can be moved.
/// 3. **pinch**. Once the user places two fingers down, the gesture recognizer enters the `.pinch` state and the view can be resized. It is not possible to go back to a pan
///               gesture: the current gesture must have ended (either by
///               lifting off all fingers, or otherwise) and a new gesture must be initiated. The pinch gesture doesn't behave like a regular pinch. The recognizer
///               always looks to the rightmost touch to determine the resize. It is easiest to use two hands.
///
/// Consumers of this class can get the new frame for the view by calling the `frame(forView:)`
/// method, passing in the view to be moved/resized. If the view has no superview it returns the original view's frame.

public class MKFloatingWindowGestureRecognizer: UIGestureRecognizer {
    
    //MARK: - Public
    
    public enum Gesture: Int {
        case none = 0
        case pan
        case pinch
    }
    
    /** The currently recognized gesture. */
    public private(set)var gesture: Gesture = .none
   
    /** Pinch gestures will allow the screen to be resized **/
    public var isResizeEnabled = true
    
    /** Returns the new frame based on the pan or pinch translation. If no resize is occuring, or if the view has no superview,
        simply returns the original frame. */
    public func frame(forView view: UIView) -> CGRect {
        
        guard let superView = view.superview else { return view.frame }
        
        let x: CGFloat = view.frame.minX + self.dX
        let y: CGFloat = view.frame.minY + self.dY
        let w: CGFloat = view.frame.width + self.dW
        let h: CGFloat = view.frame.height + self.dH
                
        let navBarHeight: CGFloat = 44
        let navBarTitleWidth: CGFloat = 200
        
        switch self.gesture {
        case .none:
            
            return view.frame
            
        case .pan:
            let minX: CGFloat = -view.frame.width + view.frame.width/2
            let maxX: CGFloat = superView.bounds.width - view.frame.width/2
            let minY: CGFloat = superView.safeAreaInsets.top
            let maxY: CGFloat = superView.bounds.height - navBarHeight
            return CGRect(x: min(max(minX, x), maxX),
                          y: min(max(minY, y), maxY),
                          width: w,
                          height: h)
            
        case .pinch:
            
            
            let minW: CGFloat = navBarTitleWidth
            let maxW: CGFloat = w
            let minH: CGFloat = navBarHeight
            let maxH: CGFloat = h
            
            return CGRect(x: x,
                          y: y,
                          width: min(max(minW, w), maxW),
                          height: min(max(minH, h), maxH))
            
        }
    }

    
    
    //MARK: - Private
    
    private var dX: CGFloat = 0.0
    private var dY: CGFloat = 0.0
    private var dW: CGFloat = 0.0
    private var dH: CGFloat = 0.0
    
    let panStartThreshold: CGFloat = 15.0
    
    private var touchRef = CGPoint()
    
    private var rightmostTouch: Int? = nil
    
    private var refView: UIView? {
        return self.view?.window
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        
        guard let refView = self.refView else {
            self.state = .failed
            return
        }
        
        // if the user is E.T. phone home
        if self.numberOfTouches > 2  {
            self.state = .failed
            return
        }
        
        guard let rightmostTouch = self.getRightmostTouch() else {
            self.state = .failed
            return
        }
        
        self.rightmostTouch = rightmostTouch
        
        self.touchRef = self.location(ofTouch: rightmostTouch, in: refView)
        
        
        // set the gesture based on the number of touches that have ever been recognized
        
        self.gesture = Gesture(rawValue: self.numberOfTouches)!
        
        // the user definitely wants to start a pinch
        if self.numberOfTouches == 2 {
            self.state = .began
        }
        
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if self.state == .failed  { return }
        
        guard let refView = self.refView else {
            self.state = .failed
            return
        }
        
        if self.gesture == .pinch {
            
            
            if self.numberOfTouches == 1 {
                self.dX = 0.0
                self.dY = 0.0
                self.dW = 0.0
                self.dH = 0.0
                return
            }
            
            guard let rightmostTouch = self.rightmostTouch else {
                return
            }
            
            let touchLocation = self.location(ofTouch: rightmostTouch, in: refView)
            

            // only resize if there are 2 fingers down
            self.dX = 0.0
            self.dY = 0.0
            
            if isResizeEnabled {
                self.dW = touchLocation.x - touchRef.x
                self.dH = touchLocation.y - touchRef.y
            }
            
            
            // reset the distance
            self.touchRef = touchLocation
            
            
        } else if self.gesture == .pan {
            
            
            let touchLocation = self.location(ofTouch: 0, in: refView)
            let distX = touchLocation.x - touchRef.x
            let distY = touchLocation.y - touchRef.y
            
            if self.state == .possible {
                
                if abs(distX) < panStartThreshold && abs(distY) < panStartThreshold {
                    return
                } else {
                    self.state = .began
                }
            }
            
            self.dX = distX
            self.dY = distY
            self.dW = 0.0
            self.dH = 0.0
            
            // reset the distance
            self.touchRef = touchLocation
            
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        if self.numberOfTouches == 1 {
            self.state = .ended
        }
    }
    
    
    public override func reset() {
        super.reset()
        self.dX = 0.0
        self.dY = 0.0
        self.dW = 0.0
        self.dH = 0.0
        self.gesture = .none
        self.rightmostTouch = nil
    }
    
    
    //MARK: - Helpers
    
    private func getRightmostTouch() -> Int? {
        
        guard let refView = self.refView else {
            return nil
        }
        
        if self.numberOfTouches < 1  || self.numberOfTouches > 2 {
            return nil
        }
        
        if self.numberOfTouches == 1 {
            return 0
        }
        
        var result: Int = 0
        var currX: CGFloat = self.location(ofTouch: 0, in: refView).x
        for i in 1..<self.numberOfTouches {
            let newX = self.location(ofTouch: i, in: refView).x
            if newX > currX {
                currX = newX
                result = i
            }
            
        }
        return result
    }
    
    
    
}
