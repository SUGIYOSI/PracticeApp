import UIKit

class SettingViewController: UIViewController {
    
    var users = [User]()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return label
    }()
    
    let UnsubscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("退会する", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(UnsubscribeTouch(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(red: 145/255, green: 181/255, blue: 242/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("プロフィールを編集", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(EditProfile(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()
    
    let Logout: UIButton = {
        let button = UIButton()
        button.setTitle("ログアウト", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(LogoutEvent(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userImage.image = UIImage(data: (NowUser.shared.nowuser.UserImage! as Data))
        userName.text = NowUser.shared.nowuser.UserName
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = false
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
        self.navigationItem.title = "設定画面"
        view.addSubview(Logout)
        view.addSubview(userImage)
        view.addSubview(userName)
        view.addSubview(settingButton)
        view.addSubview(UnsubscribeButton)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view14Height * 1.5).isActive = true
        userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: view14Height).isActive = true
        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userName.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: view14Height).isActive = true
        settingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        Logout.translatesAutoresizingMaskIntoConstraints = false
        Logout.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: view14Height * 0.8).isActive = true
        Logout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Logout.heightAnchor.constraint(equalToConstant: 50).isActive = true
        Logout.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        UnsubscribeButton.translatesAutoresizingMaskIntoConstraints = false
        UnsubscribeButton.topAnchor.constraint(equalTo: Logout.bottomAnchor, constant: view14Height * 0.8).isActive = true
        UnsubscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UnsubscribeButton.heightAnchor.constraint(equalToConstant: view14Height * 0.7).isActive = true
        UnsubscribeButton.widthAnchor.constraint(equalToConstant: view8Width * 2).isActive = true
        
    }
    
    @objc func LogoutEvent(_ sender: UIButton){
        let nc = UINavigationController(rootViewController: LoginViewController())
        self.present(nc, animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
    }
    
    @objc func EditProfile(_ sender: UIButton){
        navigationController?.pushViewController(SelfProfileSettingViewController(), animated: true)
    }
    
    @objc func UnsubscribeTouch(_ sender: UIButton){
        users.removeAll()
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        for (index,use) in users.enumerated() {
            if use.Email == NowUser.shared.nowuser.Email{
                users.remove(at: index)
            }
        }
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "users")
        userDefault.synchronize()
        let nc = UINavigationController(rootViewController: LoginViewController())
        self.present(nc, animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
