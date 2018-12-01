import UIKit

class ProfileViewController: UIViewController {
    var tapUser = User()
    var users = [User]()
    var likeSwich: Bool = true
    
    let tapUserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let LikeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.addTarget(self, action: #selector(likeButtonTap(_:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    let ProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "自己紹介"
        label.layer.cornerRadius = 12
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let ProfileTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.isEditable = false
        return textView
    }()
    
    let AgeTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 12
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 5
        label.layer.shadowColor = UIColor.black.cgColor
        return label
    }()
    
    let LivesTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 12
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 5
        label.layer.shadowColor = UIColor.black.cgColor
        return label
    }()
    
    let ColleageTextLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 0.9, alpha: 1)
        label.layer.cornerRadius = 12
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 5
        label.textAlignment = NSTextAlignment.center
        label.layer.shadowColor = UIColor.black.cgColor
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
        tapUser = NowUser.shared.tapuser
        self.navigationItem.title = tapUser.UserName
        let leftBackButton = UIBarButtonItem(barButtonHiddenItem: .Back, target: self, action: #selector(leftBackButtonClick(sender:)))
        self.navigationItem.leftBarButtonItem = leftBackButton
        
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        
            for like in tapUser.like {
                if like == NowUser.shared.nowuser.Email{
                    likeSwich = false
                }
            }
        
        
        if likeSwich == true{
            LikeButton.backgroundColor = UIColor(red: 129/255, green: 199/255, blue: 237/255, alpha: 1)
        }else{
            LikeButton.backgroundColor = UIColor(red: 0/255, green: 24/255, blue: 39/255, alpha: 1)
        }
        
        tapUserImageView.image  = UIImage(data: tapUser.UserImage! as Data)
        AgeTextLabel.text = tapUser.age
        LivesTextLabel.text = tapUser.lives
        ColleageTextLabel.text = tapUser.colleage
        ProfileTextView.text = tapUser.singleWord
        
        tabBarController?.tabBar.isHidden = true
        view.addSubview(tapUserImageView)
        view.addSubview(LikeButton)
        view.addSubview(ProfileLabel)
        view.addSubview(ProfileTextView)
        view.addSubview(AgeTextLabel)
        view.addSubview(LivesTextLabel)
        view.addSubview(ColleageTextLabel)
        
        tapUserImageView.translatesAutoresizingMaskIntoConstraints = false
        tapUserImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view14Height * 1.6).isActive = true
        tapUserImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tapUserImageView.heightAnchor.constraint(equalToConstant: view14Height * 3.5).isActive = true
        tapUserImageView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        LikeButton.translatesAutoresizingMaskIntoConstraints = false
        LikeButton.topAnchor.constraint(equalTo: tapUserImageView.bottomAnchor, constant: view14Height * 0.4).isActive = true
        LikeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view8Width * 6).isActive = true
        LikeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view8Width * 1).isActive = true
        LikeButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        ProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        ProfileLabel.topAnchor.constraint(equalTo: tapUserImageView.bottomAnchor, constant: view14Height * 0.5).isActive = true
        ProfileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view8Width * 1).isActive = true
        ProfileLabel.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        ProfileLabel.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        
        ProfileTextView.translatesAutoresizingMaskIntoConstraints = false
        ProfileTextView.topAnchor.constraint(equalTo: ProfileLabel.bottomAnchor, constant: view14Height * 0.5).isActive = true
        ProfileTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ProfileTextView.heightAnchor.constraint(equalToConstant: view14Height * 2).isActive = true
        ProfileTextView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        AgeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        AgeTextLabel.topAnchor.constraint(equalTo: ProfileTextView.bottomAnchor, constant: view14Height * 0.5).isActive = true
        AgeTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AgeTextLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        AgeTextLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        LivesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        LivesTextLabel.topAnchor.constraint(equalTo: AgeTextLabel.bottomAnchor, constant: view14Height * 0.5).isActive = true
        LivesTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LivesTextLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        LivesTextLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        ColleageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        ColleageTextLabel.topAnchor.constraint(equalTo: LivesTextLabel.bottomAnchor, constant: view14Height * 0.4).isActive = true
        ColleageTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ColleageTextLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        ColleageTextLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
    }
    
    @objc func likeButtonTap(_ semder: UIButton){
        if likeSwich == true {
            LikeButton.backgroundColor = UIColor(red: 0/255, green: 24/255, blue: 39/255, alpha: 1)
            likeSwich = false
            for use in users{
                if use.Email == tapUser.Email{
                    use.like.append(NowUser.shared.nowuser.Email!)
                }
            }
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "users")
            userDefaults.synchronize()
        }
    }
    
    @objc internal func leftBackButtonClick(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
