import UIKit

class EventPostViewController: UIViewController {
    
    var users = [User]()
    
    let eventLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "イベント名"
        return label
    }()
    
    let eventTextLabel: UILabel = {
        let label = UILabel()
        label.text = "イベントの内容"
        label.textAlignment = .center
        return label
    }()
    
    let eventTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    
    let eventNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("投稿", for:UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.addTarget(self, action: #selector(postClick(_:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "イベントを投稿して下さい"
        let leftBackButton = UIBarButtonItem(barButtonHiddenItem: .Back, target: self, action: #selector(leftBackButtonClick(sender:)))
        self.navigationItem.leftBarButtonItem = leftBackButton
        
        tabBarController?.tabBar.isHidden = true
        
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        
        let view8Width = self.view.frame.size.width / 8
        let view14Height = self.view.frame.size.height / 14
        view.addSubview(eventTextView)
        view.addSubview(eventNameTextField)
        view.addSubview(postButton)
        view.addSubview(eventLabel)
        view.addSubview(eventTextLabel)
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view14Height * 1.5).isActive = true
        eventLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventLabel.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        eventLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        
        eventNameTextField.translatesAutoresizingMaskIntoConstraints = false
        eventNameTextField.topAnchor.constraint(equalTo: eventLabel.topAnchor, constant: view14Height * 1).isActive = true
        eventNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventNameTextField.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        eventNameTextField.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
        
        eventTextLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTextLabel.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor, constant: view14Height).isActive = true
        eventTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventTextLabel.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        eventTextLabel.heightAnchor.constraint(equalToConstant: view14Height).isActive = true
        
        eventTextView.translatesAutoresizingMaskIntoConstraints = false
        eventTextView.topAnchor.constraint(equalTo: eventTextLabel.bottomAnchor, constant: view14Height * 1).isActive = true
        eventTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventTextView.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        eventTextView.heightAnchor.constraint(equalToConstant: view14Height * 4).isActive = true
        
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.topAnchor.constraint(equalTo: eventTextView.bottomAnchor, constant: view14Height * 1).isActive = true
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: view14Height * 1).isActive = true
    }
    
    @objc internal func leftBackButtonClick(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }

    @objc func postClick(_ sender: UIButton){
        for use in users {
            if use.Email == NowUser.shared.nowuser.Email{
                use.eventName = eventNameTextField.text
                use.event = eventTextView.text
            }
        }
        
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "users")
        userDefaults.synchronize()
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
