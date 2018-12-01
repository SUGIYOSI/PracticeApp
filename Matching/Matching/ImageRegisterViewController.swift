import UIKit

class ImageRegisterViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var users = [User]()
    var user = User()
    
    let UserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    let UserImagePickButton: UIButton = {
        let button = UIButton()
        button.setTitle("画像を選択", for:UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(postimage(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let UserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "名前"
        label.layer.cornerRadius = 12
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let UserName: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 12
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let ProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "自己紹介"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let ProfileTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    let RegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("登録完了", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(AllRegisterEvent(_:)), for: UIControl.Event.touchUpInside)
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
        
        NowUser.shared.tentativeUser.UserImage = UIImage(named: "setting")!.pngData()! as NSData
        UserImageView.image = UIImage(named: "setting")
        UserName.text = NowUser.shared.tentativeUser.UserName
        
        view.addSubview(UserImageView)
        view.addSubview(UserImagePickButton)
        view.addSubview(UserNameLabel)
        view.addSubview(ProfileTextView)
        view.addSubview(ProfileLabel)
        view.addSubview(RegisterButton)
        view.addSubview(UserName)
        
        UserImageView.translatesAutoresizingMaskIntoConstraints = false
        UserImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: view14Height * 1).isActive = true
        UserImageView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        UserImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UserImageView.heightAnchor.constraint(equalToConstant: view14Height * 4).isActive = true
        
        UserImagePickButton.translatesAutoresizingMaskIntoConstraints = false
        UserImagePickButton.topAnchor.constraint(equalTo: UserImageView.bottomAnchor,constant: view14Height * 0.5).isActive = true
        UserImagePickButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UserImagePickButton.widthAnchor.constraint(equalToConstant: view8Width * 4).isActive = true
        UserImagePickButton.heightAnchor.constraint(equalToConstant: view14Height * 0.6).isActive = true
        
        UserNameLabel.translatesAutoresizingMaskIntoConstraints = false
        UserNameLabel.topAnchor.constraint(equalTo: UserImagePickButton.bottomAnchor, constant: view14Height * 0.6).isActive = true
        UserNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view8Width).isActive = true
        UserNameLabel.widthAnchor.constraint(equalToConstant: view8Width * 2).isActive = true
        UserNameLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserName.topAnchor.constraint(equalTo: UserNameLabel.topAnchor).isActive = true
        UserName.leadingAnchor.constraint(equalTo: UserNameLabel.trailingAnchor, constant: view8Width * 0.5).isActive = true
        UserName.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        UserName.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        ProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        ProfileLabel.topAnchor.constraint(equalTo:  UserNameLabel.bottomAnchor,constant: view14Height * 0.3).isActive = true
        ProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfileLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        ProfileLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        ProfileTextView.translatesAutoresizingMaskIntoConstraints = false
        ProfileTextView.topAnchor.constraint(equalTo:  ProfileLabel.bottomAnchor).isActive = true
        ProfileTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfileTextView.widthAnchor.constraint(equalToConstant: view8Width * 6).isActive = true
        ProfileTextView.heightAnchor.constraint(equalToConstant: view14Height * 3).isActive = true
        
        RegisterButton.translatesAutoresizingMaskIntoConstraints = false
        RegisterButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view14Height * 2).isActive = true
        RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        RegisterButton.widthAnchor.constraint(equalToConstant: view8Width * 4).isActive = true
    }
    
    @objc func AllRegisterEvent(_ sender: UIButton){
        NowUser.shared.tentativeUser.singleWord = ProfileTextView.text
        NowUser.shared.nowuser = NowUser.shared.tentativeUser
       users.insert(NowUser.shared.nowuser, at: 0)
        //デシリアライズ
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "users")
        userDefaults.synchronize()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func postimage (_ sender: UIButton){
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage{
            UserImageView.image = image
            let imageData: NSData = image.pngData()! as NSData
            NowUser.shared.tentativeUser.UserImage = imageData
        }
        else
        {
            //ErrorMesseage
        }
        
        dismiss(animated: true, completion: nil)
    }

    
}
