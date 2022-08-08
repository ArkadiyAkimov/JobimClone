import UIKit
import MapKit

class MapVC : UIViewController , jobDataDelegate, filterDelegate {
    
    private let mapView = UtilityService.mapView
    var jobSource : [Job]!
    var JobBrowser : JobBrowserVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataService.jobRepository.subscribe(self)
        AppDataService.filterRepository.subscribe(self)
        
        overrideUserInterfaceStyle = .light
        UtilityService.mapManager.requestWhenInUseAuthorization()
        UtilityService.mapManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        //mapView.setCamera(MKMapCamera(lookingAtCenter: mapManager.location!.coordinate , fromDistance: CLLocationDistance(10000), pitch: 0, heading: 0), animated: true)
        //mapView.setUserTrackingMode(.follow, animated: true)
        mapView.delegate = self
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        let mapButton = UIButton()
        mapButton.setImage(UIImage(systemName:"location.circle.fill"), for: .normal)
        mapView.addSubview(mapButton)
        
        view.addSubview(mapView)
        UtilityService.utlt.constrainWithinSpecificVoid(mapView, view.safeAreaLayoutGuide.topAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        mapView.tintColor = UtilityService.cnfg.BrandOrange
        
        mapButton.frame = CGRect(x:10 , y: view.safeAreaLayoutGuide.layoutFrame.height - 240 , width: 50 , height: 50)
        mapButton.imageView?.tintColor = .orange
        mapButton.contentHorizontalAlignment = .fill
        mapButton.contentVerticalAlignment = .fill
        mapButton.addTarget(self, action: #selector(trackSelf), for: .touchUpInside)
        
        
        jobSource = AppDataService.jobRepository.allJobs
        loadJobDataToMap()
    }
    
    func onUpdatedSearchConditions(_ filterData: FilterData) {
        if filterData.isFilteredGlobal
        { jobSource = AppDataService.filterRepository.searchedJobs }
        else
        { jobSource = AppDataService.jobRepository.allJobs }
    }
    
    func onJobDataUpdated(_ jobData: JobData) {
        mapView.removeAnnotations(mapView.annotations)
        loadJobDataToMap()
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
    }
    
    func loadJobDataToMap(){
        if jobSource.isEmpty { print("jobSource empty") } else {
        for i in 0..<jobSource.count {
        let job = jobSource[i]
            print(job.jobTitle)
        
            if job.jobRawLocation == nil {
        CLGeocoder().geocodeAddressString(job.jobLocation) { (placemarks, error) in
            if error == nil {
            let placemark = placemarks?[0].location
            let jobAnnotation = MKPointAnnotation()
            jobAnnotation.title = "job"
            jobAnnotation.subtitle = String(i)
            jobAnnotation.coordinate = placemark!.coordinate
            self.mapView.addAnnotation(jobAnnotation)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            } else {
                print(error.debugDescription)
            }
        }
            } else {
                let jobAnnotation = MKPointAnnotation()
                jobAnnotation.title = "job"
                jobAnnotation.subtitle = String(i)
                jobAnnotation.coordinate = job.jobRawLocation
                self.mapView.addAnnotation(jobAnnotation)
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                }
           }
         }
       }
    
    @objc func trackSelf() {
        //mapView.setUserTrackingMode(.follow, animated: true)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}

extension MapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            // assign
            annotationView?.annotation = annotation
        }
        
        
        let annotationIndex : Int? = Int(annotation.subtitle!!)
        let imageView = UIImageView(image: jobSource[annotationIndex!].jobType.image)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imageView.tintColor = .white
        imageView.backgroundColor = jobSource[annotationIndex!].color
        imageView.layer.cornerRadius = (imageView.bounds.height)/2
        annotationView?.addSubview(imageView)
        annotationView?.backgroundColor = UtilityService.cnfg.BrandOrange
        
        
        return annotationView
    }
}
