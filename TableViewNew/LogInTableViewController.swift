import UIKit

class LogInTableViewController: UITableViewController {
    
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var passwordlabel: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    private let users = UsersManager.shared
    
    @IBAction func buttonLogin(_ sender: Any) {
        let userEmail = emailtext.text ?? ""
        let userPassword = passwordtext.text ?? ""
        
        if (userEmail.isEmpty && userPassword.isEmpty){
            AlertError(with: ErrorMessege.emptyFields)
        }
        if (userEmail.isEmpty){
            AlertError(with: ErrorMessege.enterEmail)
        }
        if (userPassword.isEmpty){
            AlertError(with: ErrorMessege.enterPassword)
        }
        guard let existedUserCred = users.getUserCred(with: userEmail) else {
            AlertError(with: ErrorMessege.wrongPerson)
            return
        }
        
        if (userEmail == existedUserCred.email && userPassword != existedUserCred.password) {
            AlertError(with: ErrorMessege.wrongPassword)
        }
        if (userEmail != existedUserCred.email && userPassword == existedUserCred.password) {
            AlertError(with: ErrorMessege.wrongEmails)
        }
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.present(tabBarController, animated: true)
    }
    
    func AlertError(with type: ErrorMessege) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterTableViewController") as! RegisterTableViewController
        self.present(registerViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonLogin.layer.cornerRadius = 10
        buttonLogin.layer.borderWidth = 1
        buttonLogin.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonLogin.layer.masksToBounds = true
        
        buttonRegister.layer.cornerRadius = 10
        buttonRegister.layer.borderWidth = 1
        buttonRegister.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonRegister.layer.masksToBounds = true
    }
}
