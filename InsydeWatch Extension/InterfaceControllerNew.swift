
import WatchKit
import Foundation

class InterfaceControllerNew: WKInterfaceController {
    //@IBOutlet var labelOut: WKInterfaceLabel!
    
    var num = 1
    
    @IBOutlet var btnTitle1: WKInterfaceButton!
    
    @IBOutlet var btnTitle2: WKInterfaceButton!
    
    @IBOutlet var btnTitle3: WKInterfaceButton!
    
    @IBOutlet var btnTitle4: WKInterfaceButton!
    
    @IBOutlet var btnTitle5: WKInterfaceButton!
    
    
    var copyTitlesNew : NSArray = NSArray()
    var copyTitlesTop : NSArray = NSArray()
    
    var copyIMGNew : NSArray = NSArray()
    var copyIMGTop : NSArray = NSArray()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        num = context as! Int
        //print(num)
        //Aquí se copian la parte de los 5 nuevos en array
        switch num {
        case 1:
            let copiedTop: FiveTop = FiveTop()
            copyTitlesTop=copiedTop.title
            copyIMGTop=copiedTop.imgURL
            
            setFiveTop()
        case 0:
            let copiedNew: FiveNew = FiveNew()
            copyTitlesNew=copiedNew.title
            copyIMGNew=copiedNew.imgURL
            
            setFiveNew()
        default:
            break
            
        }
        let copiedNew: FiveNew = FiveNew()
        copyTitlesNew=copiedNew.title
        copyIMGNew=copiedNew.imgURL
    }
    
    func setFiveNew(){
        btnTitle1.setTitle("\(copyTitlesNew[0])")
        btnTitle2.setTitle("\(copyTitlesNew[1])")
        btnTitle3.setTitle("\(copyTitlesNew[2])")
        btnTitle4.setTitle("\(copyTitlesNew[3])")
        btnTitle5.setTitle("\(copyTitlesNew[4])")
    }
    
    func setFiveTop(){
        btnTitle1.setTitle("\(copyTitlesTop[0])")
        btnTitle2.setTitle("\(copyTitlesTop[1])")
        btnTitle3.setTitle("\(copyTitlesTop[2])")
        btnTitle4.setTitle("\(copyTitlesTop[3])")
        btnTitle5.setTitle("\(copyTitlesTop[4])")
    }
    
    //Aquí se cambian los botones
    
    @IBAction func btn1Actn() {
        print(num,",",1)
        pushController(withName: "DetailInterface", context:[num,0])
    }
    @IBAction func btn2Actn() {
        print(num,",",2)
        pushController(withName: "DetailInterface", context:[num,1])
    }
    @IBAction func btn3Actn() {
        print(num,",",3)
        pushController(withName: "DetailInterface", context:[num,2])
    }
    @IBAction func btn4Actn() {
        print(num,",",4)
        pushController(withName: "DetailInterface", context:[num,3])
    }
    @IBAction func btn5Actn() {
        print(num,",",5)
        pushController(withName: "DetailInterface", context:[num,4])
    }
    
    
    
}
