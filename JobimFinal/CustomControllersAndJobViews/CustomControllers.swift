import UIKit

class CustomViewController : UIViewController {
    var customTrianlgeView : CustomTriangleView!
    var mainMenu : MainMenuVC!
    
    @objc func pushMenu (){
        mainMenu.pushSelf()
        self.view.addSubview(mainMenu.coverView)
        UtilityService.utlt.constrainEquallyWithinVoid(self.view, mainMenu.coverView, 0, false)
        dismissSelfPartially()
    }
    
    @objc func dismissSelfPartially() {
        self.view.bringSubviewToFront(customTrianlgeView)
        UIWindow.animate(withDuration: 0.3, delay: 0) {
            self.view.transform = CGAffineTransform(translationX: self.view.bounds.width * 0.85 , y: 0)
            self.customTrianlgeView.transform = CGAffineTransform(translationX: 0 , y: -self.view.bounds.height)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class SimpleViewController : UIViewController {
    
    @objc func dismissSelfFully() {
        UIWindow.animate(withDuration: 0.3, delay: 0) {
            self.view.transform = CGAffineTransform(translationX: self.view.bounds.width , y: 0)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


