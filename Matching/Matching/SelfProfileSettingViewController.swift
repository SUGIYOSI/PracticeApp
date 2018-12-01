import UIKit

class SelfProfileSettingViewController: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate , UITextFieldDelegate{
    
    var users = [User]()
    
    let UserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let UserNameField: UITextField = {
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
    
    let ProfileTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    
    let UserImagePickButton: UIButton = {
        let button = UIButton()
        button.setTitle("画像を変更", for:UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(postImage(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let DetailSettingButton: UIButton = {
        let button = UIButton()
        button.setTitle("詳細を再設定", for:UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(DetailSettingClick(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let ReRegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("完了", for: UIControl.State.normal)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
        UserImageView.image = UIImage(data: (NowUser.shared.nowuser.UserImage! as Data))
        UserNameField.text = NowUser.shared.nowuser.UserName
        ProfileTextView.text = NowUser.shared.nowuser.singleWord
        PasswordField.text = NowUser.shared.nowuser.Password
        
        self.navigationItem.title = "プロフィール設定"
        let leftBackButton = UIBarButtonItem(barButtonHiddenItem: .Back, target: self, action: #selector(leftBackButtonClick(sender:)))
        self.navigationItem.leftBarButtonItem = leftBackButton
        
        view.addSubview(UserImageView)
        view.addSubview(UserNameField)
        view.addSubview(PasswordField)
        view.addSubview(ProfileTextView)
        view.addSubview(ReRegisterButton)
        view.addSubview(UserImagePickButton)
        view.addSubview(ReRegisterButton)
        view.addSubview(DetailSettingButton)
        
        UserImageView.translatesAutoresizingMaskIntoConstraints = false
        UserImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view14Height * 1.5).isActive = true
        UserImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UserImageView.heightAnchor.constraint(equalToConstant: view14Height * 3).isActive = true
        UserImageView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        UserNameField.translatesAutoresizingMaskIntoConstraints = false
        UserNameField.topAnchor.constraint(equalTo: UserImageView.bottomAnchor, constant: view14Height * 0.6).isActive = true
        UserNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UserNameField.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        UserNameField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        PasswordField.translatesAutoresizingMaskIntoConstraints = false
        PasswordField.topAnchor.constraint(equalTo: UserNameField.bottomAnchor, constant: view14Height * 0.6).isActive = true
        PasswordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PasswordField.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        PasswordField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        ProfileTextView.translatesAutoresizingMaskIntoConstraints = false
        ProfileTextView.topAnchor.constraint(equalTo: PasswordField.bottomAnchor, constant: view14Height * 0.6).isActive = true
        ProfileTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfileTextView.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        ProfileTextView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        ReRegisterButton.translatesAutoresizingMaskIntoConstraints = false
        ReRegisterButton.topAnchor.constraint(equalTo: ProfileTextView.bottomAnchor, constant: view14Height * 1).isActive = true
        ReRegisterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view8Width * 0.7).isActive = true
        ReRegisterButton.heightAnchor.constraint(equalToConstant: view14Height * 1.5).isActive = true
        ReRegisterButton.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        
        UserImagePickButton.translatesAutoresizingMaskIntoConstraints = false
        UserImagePickButton.topAnchor.constraint(equalTo: ProfileTextView.bottomAnchor , constant: view14Height * 0.7).isActive = true
        UserImagePickButton.leadingAnchor.constraint(equalTo: ReRegisterButton.trailingAnchor, constant: view8Width).isActive = true
        UserImagePickButton.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        UserImagePickButton.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        
        DetailSettingButton.translatesAutoresizingMaskIntoConstraints = false
        DetailSettingButton.topAnchor.constraint(equalTo: UserImagePickButton.bottomAnchor, constant: view14Height).isActive = true
        DetailSettingButton.leadingAnchor.constraint(equalTo: UserImagePickButton.leadingAnchor).isActive = true
        DetailSettingButton.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        DetailSettingButton.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
    }
    
    @objc func DetailSettingClick(_ sender: UIButton){
        navigationController?.pushViewController(ReDetailProfileViewController(), animated: true)
    }
    
    @objc func ReRegisterEvent(_ sender: UIButton){
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        for use in users {
            if use.Email == NowUser.shared.nowuser.Email{
                use.UserName = UserNameField.text
                use.Password = PasswordField.text
                use.singleWord = ProfileTextView.text
                use.UserImage = NowUser.shared.nowuser.UserImage
                NowUser.shared.nowuser = use
            }
        }
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "users")
        userDefault.synchronize()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func postImage(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
        }
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as! UIImage?{
            UserImageView.image = image
            let imageData: NSData? = image.pngData() as NSData?
            NowUser.shared.nowuser.UserImage = imageData
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc internal func leftBackButtonClick(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
