import UIKit


class MenuCustomOverlayView: UIView {

    var radius: CGFloat = 100 { didSet { updateMask() } }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        //let center = CGPoint(x: bounds.midX, y: bounds.minY)
        //path.addArc(withCenter: center, radius: radius, startAngle: .pi, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: bounds.maxX * 0.75 , y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX * 0.90 , y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}

