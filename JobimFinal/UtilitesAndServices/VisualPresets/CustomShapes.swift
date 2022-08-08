import UIKit


class CustomTriangleView : UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}


class JobViewContactsCutout : UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY * 0.2))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}


class JobBrowserImageCutout : UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY * 0.2))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}

class MapForJobViewCutout : UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.minX ,y: bounds.maxY * 0.2))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}

class PageUnderView : UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        updateMask()
    }

    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.minX ,y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY * 0.2))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}
