import UIKit

public extension UIImage {
    
    static func randomSystemImage() -> UIImage? {
        for _ in 0..<10 {
            let name = systemImageNames.randomElement()!
            if let image = UIImage(systemName: name) {
                return image
            } else {
                print("MKSwiftUIKit.randomSystemImage() failed: could not locate image named \(name). Trying again (max 10 attempts before this function returns nil.")
            }
        }
        return nil
    }
    
}


private let systemImageNames: [String] = [
    "figure.walk",
    "cloud.sun.fill",
    "person.fill",
    "doc.fill",
    "slider.vertical.3",
    "square.and.arrow.up",
    "folder",
    "paperplane",
    "tray.fill",
    "lasso",
    "pencil",
    "trash.fill",
    "signature",
    "cart.fill.badge.plus",
    "music.note",
    "eurosign.circle",
    "option",
    "eject.fill",
    "keyboard",
    "projective",
    "clock",
    "airplane",
    "tram.fill",
    "figure.wave",
    "heart.fill",
    "waveform.path.ecg",
    "play.fill",
    "forward.fill",
    "backward.fill",
    "forward",
    "forward.fill",
    "backward.end",
    "backward.end.fill",
    "forward.end",
    "forward.end.fill",
    "backward.end.alt",
    "backward.end.alt.fill",
    "forward.end.alt",
    "forward.end.alt.fill",
    "shuffle",
    "repeat",
    "repeat.1",
    "goforward",
    "gobackward",
    "goforward.10",
    "mic",
    "mic.fill",
    "mic.circle",
    "mic.circle.fill",
    "mic.slash",
    "mic.slash.fill",
    "message",
    "message.fill",
    "message.circle",
    "message.circle.fill",
    "bubble.right",
    "bubble.right.fill",
    "bubble.left",
    "bubble.left.fill",
    "exclamationmark.bubble",
    "exclamationmark.bubble.fill",
    "quote.bubble",
    "quote.bubble.fill",
    "text.bubble",
    "text.bubble.fill",
    "captions.bubble",
    "captions.bubble.fill",
    "plus.bubble",
    "plus.bubble.fill",
    "bubble.middle.bottom",
    "bubble.middle.bottom.fill",
    "bubble.middle.top",
    "bubble.middle.top.fill",
    "bubble.left.and.bubble.right",
    "bubble.left.and.bubble.right.fill",
    "phone",
    "phone.fill",
    "phone.circle",
    "phone.circle.fill",
    "phone.badge.plus",
    "phone.fill.badge.plus",
    "phone.arrow.up.right",
    "phone.fill.arrow.up.right",
    "phone.arrow.down.left",
    "phone.fill.arrow.down.left",
    "phone.arrow.right",
    "phone.fill.arrow.right",
    "phone.down",
    "phone.down.fill",
    "phone.down.circle",
    "phone.down.circle.fill",
    "teletype",
    "teletype.answer",
    "video",
    "video.fill",
    "video.circle",
    "video.circle.fill",
    "video.slash",
    "video.slash.fill",
    "video.badge.plus",
    "arrow.up.right.video",
    "arrow.up.right.video.fill",
    "arrow.down.left.video",
    "arrow.down.left.video.fill",
    "questionmark.video",
    "questionmark.video.fill",
    "sum",
    "percent",
    "function",
    "plus",
    "plus.circle",
    "plus.circle.fill",
    "plus.square",
    "plus.square.fill",
    "plus.rectangle",
    "plus.rectangle.fill",
    "minus",
    "minus.circle",
    "minus.circle.fill",
    "minus.square",
    "minus.square.fill",
    "minus.rectangle",
    "minus.rectangle.fill",
    "plusminus",
    "plusminus.circle",
    "plusminus.circle.fill",
    "multiply",
    "multiply.circle",
    "multiply.circle.fill",
    "multiply.square",
    "multiply.square.fill",
    "divide",
    "divide.circle",
    "divide.circle.fill",
    "divide.square",
    "divide.square.fill",
    "equal",
    "equal.circle",
    "equal.circle.fill",
    "equal.square",
    "equal.square.fill",
    "lessthan",
    "lessthan.circle",
    "lessthan.circle.fill",
    "lessthan.square",
    "lessthan.square.fill",
    "greaterthan",
]
