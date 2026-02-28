
import UIKit
extension UIView {

    func applyGradientBorder(colors: [UIColor], lineWidth: CGFloat = 3) {

        layoutIfNeeded()   // 👈 MUHIM

        layer.sublayers?
            .filter { $0.name == "gradientBorderLayer" }
            .forEach { $0.removeFromSuperlayer() }

        let gradient = CAGradientLayer()
        gradient.name = "gradientBorderLayer"
        gradient.frame = self.bounds   // 👈 self.bounds aniq

        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)

        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(
            roundedRect: self.bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2),
            cornerRadius: self.layer.cornerRadius
        ).cgPath

        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.black.cgColor

        gradient.mask = shape
        self.layer.addSublayer(gradient)
    }
}
