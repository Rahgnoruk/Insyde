
import WatchKit
import Foundation

class InterfaceControllerLast: WKInterfaceController {
    //@IBOutlet var labelOut: WKInterfaceLabel!
    
    var num : [Int] = []
    
    @IBOutlet var labelFin: WKInterfaceLabel!
    @IBOutlet var imgFinal: WKInterfaceImage!
    
    
    var copyTitlesNew : NSArray = NSArray()
    var copyTitlesTop : NSArray = NSArray()
    
    var copyIMGNew : NSArray = NSArray()
    var copyIMGTop : NSArray = NSArray()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        //num = context[0] as! Int
        num=context as! [Int]
        
        print(context)
        //Aquí se copian la parte de los 5 nuevos en array
        switch num[0]{
        case 1:
            var copiedTop: FiveTop = FiveTop()
            copyTitlesTop=copiedTop.title
            copyIMGTop=copiedTop.imgURL
            
            setFiveTop()
        case 0:
            var copiedNew: FiveNew = FiveNew()
            copyTitlesNew=copiedNew.title
            copyIMGNew=copiedNew.imgURL
            
            setFiveNew()
        default:
            break
            
        }
        var copiedNew: FiveNew = FiveNew()
        copyTitlesNew=copiedNew.title
        copyIMGNew=copiedNew.imgURL
    }
    
    func setFiveNew(){
    print("Title=",copyTitlesNew[num[1]],"IMGURL",copyIMGNew[num[1]])
    labelFin.setText("\(copyTitlesNew[num[1]])")
    }
    
    func setFiveTop(){
    print("Title=",copyTitlesTop[num[1]],"IMGURL",copyIMGTop[num[1]])
    labelFin.setText("\(copyTitlesTop[num[1]])")
    }
    
    
}

