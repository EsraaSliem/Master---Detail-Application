
import Foundation
import UIKit
import QuartzCore
import MapKit
import CoreLocation

import UIKit

@IBDesignable
class RounderSegmented: UISegmentedControl {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var _borderWidth: CGFloat = 3
    @IBInspectable var _borderColor: UIColor? = UIColor.white
    //    @IBInspectable var _shadowOpacity: Float = 0.5
    
    override func awakeFromNib() {
        layer.cornerRadius = _cornerRadius
        layer.borderWidth = _borderWidth
        layer.borderColor = _borderColor?.cgColor
        //        layer.borderWidth = borderWidth
        //        layer.borderColor =
        layer.masksToBounds = true
    }
}
extension UISegmentedControl {
    
    func fallBackToPreIOS13Layout(using tintColor: UIColor) {
        if #available(iOS 13, *) {
            let backGroundImage = UIImage(color: .clear, size: CGSize(width: 1, height: 32))
            let dividerImage = UIImage(color: tintColor, size: CGSize(width: 1, height: 32))
            
            setBackgroundImage(backGroundImage, for: .normal, barMetrics: .default)
            setBackgroundImage(dividerImage, for: .selected, barMetrics: .default)
            
            setDividerImage(dividerImage,
                            forLeftSegmentState: .normal,
                            rightSegmentState: .normal, barMetrics: .default)
            
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
            
            setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
            setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        } else {
            self.tintColor = tintColor
        }
    }
}
extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        ctx.fill(CGRect(origin: .zero, size: size))
        guard
            let image = UIGraphicsGetImageFromCurrentImageContext(),
            let imagePNGData = image.pngData()
            else { return nil }
        UIGraphicsEndImageContext()
        
        self.init(data: imagePNGData)
    }
}
typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    case BottomUp
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        switch self {
        case .topRightBottomLeft:
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .topLeftBottomRight:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1, y: 1))
        case .horizontal:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        case .BottomUp :
            return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
        }
    }
}

extension UIView {
    
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
       if self.layer.sublayers != nil {
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation ,radius:CGFloat) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        if self.layer.sublayers != nil {
            self.layer.sublayers?[0].removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    func loadViewFromNib(_ nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
