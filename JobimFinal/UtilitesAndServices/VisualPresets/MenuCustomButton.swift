import UIKit

class menuCustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
    }
    
    var fillColorCGColor = UIColor.clear.cgColor
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //UIBezierPath()
        
        context.beginPath()
        context.move(to:  rect.origin)
        context.addLine(to: CGPoint(x: rect.minX,y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(fillColorCGColor)
        context.fillPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


