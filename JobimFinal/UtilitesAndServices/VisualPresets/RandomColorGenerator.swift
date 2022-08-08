import UIKit

class RandomColorGenerator {
    
    var colorIndex = 0
    var roundedValue : String!
    
func produceColor() -> UIColor {
    
    
    var outPutColor : UIColor

    switch UtilityService.colorSeed {
    case 1 :
        outPutColor = UIColor(hue: 0.56, saturation: 0.6, brightness: 0.85, alpha: 1)
        roundedValue = "WashedBlue"
        UtilityService.colorSeed += 1
        break
    case 2:
        outPutColor = UIColor(hue: 0.42, saturation: 0.8, brightness: 0.6, alpha: 1)
        roundedValue = "WashedGreen"
        UtilityService.colorSeed += 1
        break
    case 3 :
        outPutColor = UIColor(hue: 0.68, saturation: 0.6, brightness: 0.8, alpha: 1)
        roundedValue = "WashedPurple"
        UtilityService.colorSeed += 1
        break
    case 4:
        outPutColor = UIColor(hue: 0, saturation: 0, brightness: 0.16, alpha: 1)
        roundedValue = "DarkGray"
        UtilityService.colorSeed += 1
        break
    case 5:
        outPutColor = UIColor(hue: 0.05, saturation: 0.8, brightness: 0.9, alpha: 1)
        roundedValue = "Orange"
        UtilityService.colorSeed += 1
        break
    case 6 :
        outPutColor = UIColor(hue: 0.6, saturation: 0.8, brightness: 0.7, alpha: 1)
        roundedValue = "Blue"
        UtilityService.colorSeed += 1
        break
    case 7:
        outPutColor = UIColor(hue: 0.75, saturation: 0.8, brightness: 0.6, alpha: 1)
        roundedValue = "Purple"
        UtilityService.colorSeed += 1
        break
    case 8:
        outPutColor = UIColor(hue: 0.35, saturation: 0.85, brightness: 0.45, alpha: 1)
        roundedValue = "LeafGreen"
        UtilityService.colorSeed += 1
        break
    default :
        outPutColor = UIColor(hue: 0, saturation: 0.8, brightness: 0.7 ,alpha: 1)
        roundedValue = "Red"
        UtilityService.colorSeed += 1
        break
    }
    
    if UtilityService.colorSeed == 9 {
        UtilityService.colorSeed = 0
    }
    
    return outPutColor
  }
    
}
