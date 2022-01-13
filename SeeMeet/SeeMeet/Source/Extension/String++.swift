import UIKit

extension String {
    static public func getAttributedText(text: String, letterSpacing: CGFloat?, lineSpacing: CGFloat?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        if let letterSpacing = letterSpacing {
            attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: text.count))
        }
        
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        }
        
        return NSAttributedString(attributedString: attributedString)
    }
}
