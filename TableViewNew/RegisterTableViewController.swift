import UIKit
import Foundation

class RegisterTableViewController: UITableViewController {
    
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private enum LocalConstant {
        static let minPasswordLength = 5
    }
    
    private let users = UsersManager.shared
    
    @IBAction func loginButton(_ sender: Any) {
        let logInViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInTableViewController") as! LogInTableViewController
        self.present(logInViewController, animated: true)
    }
    
    @IBAction func registerButton(_ sender: AnyObject) {
        
        let userName = nameText.text ?? ""
        let userEmail = emailText.text ?? ""
        let userPassword = passwordText.text ?? ""
        let userConfirmPassword = confirmPasswordText.text ?? ""
        
        if (userName.isEmpty && userEmail.isEmpty && userPassword.isEmpty && userConfirmPassword.isEmpty){
            AlertError(with: ErrorMessege.emptyFields)
        }
        if (userName.isEmpty){
            AlertError(with: ErrorMessege.name)
        }
        if (userPassword.isEmpty && userConfirmPassword.isEmpty){
            AlertError(with: ErrorMessege.setPassword)
        }
        if (!userPassword.isEmpty && userPassword.count < LocalConstant.minPasswordLength){
            AlertError(with: ErrorMessege.morePassword)
        }
        if (!userPassword.isEmpty && userConfirmPassword.isEmpty){
            AlertError(with: ErrorMessege.confirmPassword)
        }
        if (userPassword != userConfirmPassword){
            AlertError(with: ErrorMessege.notMatch)
        }
        if isValidEmail(email: userEmail) == false {
            AlertError(with: ErrorMessege.errorEmail)
        }
        if let user = users.getUserCred(with: userName) {
            AlertError(with: ErrorMessege.wrongEmail)
        } else {
            users.saveUser(with: userEmail, password: userPassword)
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
    
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginButton.layer.masksToBounds = true
        
        registerButton.layer.cornerRadius = 10
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        registerButton.layer.masksToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
