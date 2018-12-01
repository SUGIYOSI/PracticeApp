import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var users = [User]()
    var user = User()
    
    let RegisterLabel: UILabel = {
        let label = UILabel()
        label.text = "登録"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.italicSystemFont(ofSize: 40)
        return label
    }()
    
    let UserNameField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let EmailField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let PasswordField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let UserNameImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let EmailImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let PassWordImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let RegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("次へ進む", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ReRegisterEvent(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()
    
    let LoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("ログイン", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(Login(_:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        
        UserNameField.delegate = self
        EmailField.delegate = self
        PasswordField.delegate = self
        UserNameField.placeholder = "名前を入力"
        EmailField.placeholder = "メールアドレスを入力"
        PasswordField.placeholder = "パスワードを入力"
        UserNameField.clearButtonMode = .always
        EmailField.clearButtonMode = .always
        PasswordField.clearButtonMode = .always
        
        view.addSubview(RegisterLabel)
        view.addSubview(UserNameField)
        view.addSubview(EmailField)
        view.addSubview(PasswordField)
        view.addSubview(RegisterButton)
        view.addSubview(LoginButton)
        
        RegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        RegisterLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: view14Height * 1).isActive = true
        RegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        RegisterLabel.heightAnchor.constraint(equalToConstant: view14Height * 1.5).isActive = true
        
        UserNameField.translatesAutoresizingMaskIntoConstraints = false
        UserNameField.topAnchor.constraint(equalTo: RegisterLabel.bottomAnchor,constant: view14Height * 1).isActive = true
        UserNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UserNameField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        UserNameField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        EmailField.translatesAutoresizingMaskIntoConstraints = false
        EmailField.topAnchor.constraint(equalTo: UserNameField.bottomAnchor,constant: view14Height * 1).isActive = true
        EmailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        EmailField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        EmailField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        PasswordField.translatesAutoresizingMaskIntoConstraints = false
        PasswordField.topAnchor.constraint(equalTo: EmailField.bottomAnchor, constant: view14Height * 1).isActive = true
        PasswordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PasswordField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        PasswordField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        RegisterButton.translatesAutoresizingMaskIntoConstraints = false
        RegisterButton.topAnchor.constraint(equalTo: PasswordField.bottomAnchor, constant: view14Height * 1).isActive = true
        RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        LoginButton.topAnchor.constraint(equalTo: RegisterButton.bottomAnchor, constant: view14Height * 1).isActive = true
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.widthAnchor.constraint(equalToConstant: view8Width * 4).isActive = true
        LoginButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
    }

    @objc internal func ReRegisterEvent(_ sender: UIButton){
        if(UserNameField.text == "" || EmailField.text == "" || PasswordField.text == ""){
            displayMyAlertMessage(userMessage: "全てのフォームに入力してください。")
            return
        }
        NowUser.shared.tentativeUser.UserName = UserNameField.text
        NowUser.shared.tentativeUser.Email    = EmailField.text
        NowUser.shared.tentativeUser.Password = PasswordField.text
        navigationController?.pushViewController(ReRegisterViewController(), animated: true)
    }
    
    @objc internal func Login(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    //アラートメッセージ表示
    func displayMyAlertMessage(userMessage: String){
        let myAlert = UIAlertController(title:"警告", message: userMessage, preferredStyle:  UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler:nil)
        myAlert.addAction(okAction);
        self.present(myAlert,animated:true, completion:nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
