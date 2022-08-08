import UIKit
import MapKit

struct AppDataService {
    static var userRepository : UserData!
    static var jobRepository : JobData!
    static var filterRepository : FilterData!
}

struct UtilityService {
    static var unpublishedJob = Job(random: false)
    static var utlt : Utility!
    static var cnfg : Configuration!
    static var colorSeed : Int! = 0
    static let mapManager = CLLocationManager()
    static let mapView = MKMapView()
    static let randomColorGenerator = RandomColorGenerator()
}
