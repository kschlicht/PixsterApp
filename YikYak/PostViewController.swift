
//  PostViewController.swift


import UIKit

class PostViewController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var parseTestPostView: UITextView!
    @IBOutlet weak var parseImagePostView: UIImageView!
    var currLocation: CLLocationCoordinate2D?
    var reset:Bool = false
    let locationManager = CLLocationManager()

    private func  alert() {
        let alert = UIAlertController(title: "Cannot fetch your location", message: "Please enable location in the settings menu", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default) { (action) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                return
            }
        alert.addAction(settings)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parseTestPostView.selectedRange = NSMakeRange(0, 0);
        self.parseTestPostView.delegate = self
        self.parseTestPostView  .becomeFirstResponder()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager.stopUpdatingLocation()
        if(locations.count > 0){
            let location = locations[0] as CLLocation
            currLocation = location.coordinate
        } else {
            alert()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    

    
    @IBAction func postPressed(sender: AnyObject) {
        
        if(currLocation != nil){
            
            
            
            let imageData = UIImagePNGRepresentation(parseImagePostView.image)
            let imageFile = PFFile(name: "picOne.png", data:imageData)
            let testObject = PFObject(className: "Yak")
            testObject["text"] = self.parseTestPostView.text
            testObject["count"] = 0
            testObject["replies"] = 0            
            testObject["location"] = PFGeoPoint(latitude: currLocation!.latitude , longitude: currLocation!.longitude)
            testObject["comments"] = []
            //testObject["imageName"] = "picOne"
            testObject["profileImage"] = imageFile
            testObject.saveInBackground()
            self.dismissViewControllerAnimated(true , completion: nil)
            
            
            
            
            
        } else {
            alert()
        }

    }
    
    
       @IBAction func openPhotoLibrary(sender: UIButton) {
        var photoSelector = UIImagePickerController()
        photoSelector.delegate = self
        photoSelector.sourceType = .PhotoLibrary
        
        self.presentViewController(photoSelector, animated: true, completion: nil);

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let imagePicked:UIImage = info [UIImagePickerControllerOriginalImage] as UIImage
        
        let scaledImage = self.scaleImageWith(imagePicked, and: CGSize(width: 200,height: 200))
        
        
        parseImagePostView.image = scaledImage
        
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
        
        

    }
    

   
    
    func scaleImageWith(image:UIImage, and newSize: CGSize) ->UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    
    
    
    
    
    
    func textViewDidChange(textView: UITextView) {
        if(reset == false){
            self.parseTestPostView.text = String(Array(self.parseTestPostView.text)[0])
            reset = true
        }
      
    
    }

    
    /*
    func imageViewDidChange(imageView: UIImageView) {
        if(reset == false){
            self.parseImagePostView.image = PFFile(self.parseImagePostView.image)[0];)
            reset = true
        }
    */
    }
