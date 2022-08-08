import UIKit

class UserData {
    var userImage: UIImage? // last name updates it
    var firstName : String? // last name updates it
    var lastName : String?   { didSet { updateData() }}
    var cityOfResidence : String? { didSet { updateData() }}
    var birthDate : String?  { didSet { updateData() }}
    var emailAdress: String? { didSet { updateData() }}
    var isNotificationsAndUpdatesOn: Bool = true
    
    init( firstName: String, lastName : String, cityOfResidence: String, Image: UIImage?, birthDate : String,
          emailAdress : String, isNotificationsAndUpdatesOn : Bool){
        self.firstName = firstName
        self.lastName = lastName
        self.cityOfResidence = cityOfResidence
        self.userImage = Image
        self.birthDate = birthDate
        self.emailAdress = emailAdress
        self.isNotificationsAndUpdatesOn = isNotificationsAndUpdatesOn
    }
    
    func getFullName () -> String {
        return firstName! + " " + lastName!
    }
    
    var subscribers = [userDataDelegate]()
    
    func subscribe(_ delegate: userDataDelegate) {
        subscribers.append(delegate)
    }
    
    func updateData () {
        for subscriber in subscribers {
            subscriber.onUserDataUpdated(self)
        }
    }
}

protocol userDataDelegate {
    func onUserDataUpdated (_ userData: UserData)
}
