// MARK: IMPORT STATEMENTS
import UIKit

// MARK: POP UP VIEW CONTROLLER - CLASS
class PopUpViewController: UIViewController {

    // MARK: PROPERTIES
    var delegate: MantleViewDelegate!
    
    // MARK: VIEW DID LOAD - FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeView(sender: AnyObject) {
        delegate.dismissView(animated: true)
    }

}
