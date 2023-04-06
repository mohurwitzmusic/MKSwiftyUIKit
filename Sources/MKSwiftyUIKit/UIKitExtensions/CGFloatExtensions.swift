// Credit: https://easings.net

import UIKit

public extension CGFloat {
            
    func easeInSine() -> CGFloat {
        return 1 - cos((self * CGFloat.pi) / 2);
    }
    
    func easeOutSine() -> CGFloat {
        return sin((self * CGFloat.pi) / 2);
    }
    
    func easeInOutSine() -> CGFloat {
        return -(cos(CGFloat.pi * self) - 1) / 2;
    }
    
    func easeInQuad() -> CGFloat {
        return self * self;
    }

    func easeOutQuad() -> CGFloat {
        return 1 - (1 - self) * (1 - self);
    }

    func easeInOutQuad() -> CGFloat {
        return self < 0.5 ? 2 * self * self : 1 - pow(-2 * self + 2, 2) / 2;
    }

    func easeInCubic() -> CGFloat {
        return self * self * self;
    }

    func easeOutCubic() -> CGFloat {
        return 1 - pow(1 - self, 3);
    }

    func easeInOutCubic() -> CGFloat {
        return self < 0.5 ? 4 * self * self * self : 1 - pow(-2 * self + 2, 3) / 2;
    }

    func easeInQuart() -> CGFloat {
        return self * self * self * self;
    }

    func easeOutQuart() -> CGFloat {
        return 1 - pow(1 - self, 4);
    }

    func easeInOutQuart() -> CGFloat {
        return self < 0.5 ? 8 * self * self * self * self : 1 - pow(-2 * self + 2, 4) / 2;
    }

    func easeInQuint() -> CGFloat {
        return self * self * self * self * self;
    }

    func easeOutQuint() -> CGFloat {
        return 1 - pow(1 - self, 5);
    }

    func easeInOutQuint() -> CGFloat {
        return self < 0.5 ? 16 * self * self * self * self * self : 1 - pow(-2 * self + 2, 5) / 2;
    }

    func easeInExpo() -> CGFloat {
        return self == 0 ? 0 : pow(2, 10 * self - 10);
    }

    func easeOutExpo() -> CGFloat {
        return self == 1 ? 1 : 1 - pow(2, -10 * self);
    }

    func easeInOutExpo() -> CGFloat {
        return self == 0
      ? 0
      : self == 1
      ? 1
      : self < 0.5 ? pow(2, 20 * self - 10) / 2
      : (2 - pow(2, -20 * self + 10)) / 2;
    }

    func easeInCirc() -> CGFloat {
        return 1 - sqrt(1 - pow(self, 2));
    }

    func easeOutCirc() -> CGFloat {
        return sqrt(1 - pow(self - 1, 2));
    }

    func easeInOutCirc() -> CGFloat {
        return self < 0.5
      ? (1 - sqrt(1 - pow(2 * self, 2))) / 2
      : (sqrt(1 - pow(-2 * self + 2, 2)) + 1) / 2;
    }

    func easeInBack() -> CGFloat {
        let c1: CGFloat = 1.70158
        let c3: CGFloat = c1 + 1
        return c3 * self * self * self - c1 * self * self;
    }

    func easeOutBack() -> CGFloat {
        let c1: CGFloat = 1.70158;
        let c3: CGFloat = c1 + 1;
        return 1 + c3 * pow(self - 1, 3) + c1 * pow(self - 1, 2);
    }


    func easeInOutBack() -> CGFloat {
        let c1: CGFloat = 1.70158
        let c2: CGFloat = c1 * 1.525

        return self < 0.5
        ? (pow(2 * self, 2) * ((c2 + 1) * 2 * self - c2)) / 2
        : (pow(2 * self - 2, 2) * ((c2 + 1) * (self * 2 - 2) + c2) + 2) / 2;
    }
    
}
