import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{
    
    var users = [User]()
    var user = User()
    
    let RoginLabel: UILabel = {
        let label = UILabel()
        label.text = "ログイン"
        label.font = UIFont.italicSystemFont(ofSize: 40)
        label.textAlignment = NSTextAlignment.center
        return label
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
    
    let LoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("ログイン", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.addTarget(self, action: #selector(LoginEvent(_:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()
    
    let RegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("登録する", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        button.addTarget(self, action: #selector(RegisterEvent(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let EmailImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let PassWordImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        
        EmailField.delegate = self
        PasswordField.delegate = self
        EmailField.placeholder = "メールアドレスを入力"
        PasswordField.placeholder = "パスワードを入力"
        EmailField.clearButtonMode = .always
        PasswordField.clearButtonMode = .always
        
        
        view.addSubview(RoginLabel)
        view.addSubview(EmailField)
        view.addSubview(PasswordField)
        view.addSubview(LoginButton)
        view.addSubview(RegisterButton)
        view.addSubview(EmailImage)
        view.addSubview(PassWordImage)
        
        
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
    
        RoginLabel.translatesAutoresizingMaskIntoConstraints = false
        RoginLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: view14Height * 1).isActive = true
        RoginLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        RoginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RoginLabel.heightAnchor.constraint(equalToConstant: view14Height * 2).isActive = true

        EmailField.translatesAutoresizingMaskIntoConstraints = false
        EmailField.topAnchor.constraint(equalTo: RoginLabel.bottomAnchor,constant: view14Height * 1).isActive = true
        EmailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        EmailField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        EmailField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        PasswordField.translatesAutoresizingMaskIntoConstraints = false
        PasswordField.topAnchor.constraint(equalTo: EmailField.bottomAnchor, constant: view14Height * 1).isActive = true
        PasswordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PasswordField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        PasswordField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        LoginButton.topAnchor.constraint(equalTo: PasswordField.bottomAnchor, constant: view14Height * 1).isActive = true
        LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        LoginButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        RegisterButton.translatesAutoresizingMaskIntoConstraints = false
        RegisterButton.topAnchor.constraint(equalTo: LoginButton.bottomAnchor, constant: view14Height * 1).isActive = true
        RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterButton.widthAnchor.constraint(equalToConstant: view8Width * 4).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
    }

    @objc func RegisterEvent(_ sender: UIButton){
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func LoginEvent(_ sender: UIButton){
        //ログインできるかどうか調べる
        for use in users {
            if use.Email == EmailField.text{
                if use.Password == PasswordField.text{
                    user = use
                }
            }
        }
        //ログインできなかった場合
        if user.Email == nil{
            displayMyAlertMessage(userMessage: "IDかパスワードが一致していません。")
            return
        }
        //ユーザー情報をシングルトンに保存してホーム画面に戻る
        NowUser.shared.nowuser = user
        dismiss(animated: true, completion: nil)
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
