import UIKit

class EventViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var users = [User]()
    var eventUsers = [User]()
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        users.removeAll()
        eventUsers.removeAll()
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        
        for use in users {
            if use.event != nil {
                eventUsers.append(use)
            }
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        self.navigationItem.title = "イベント"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 173/255, green: 247/255, blue: 181/255, alpha: 1)
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(postEvent(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: viewWidth, height: viewHeight )
        tableView.register(EventCustomCell.self, forCellReuseIdentifier: "EventCustomCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCustomCell",for: indexPath as IndexPath) as! EventCustomCell
         cell.eventTitleLabel.text = eventUsers[indexPath.row].eventName
         cell.eventTextView.text = eventUsers[indexPath.row].event
         cell.userImage.image =  UIImage(data: (eventUsers[indexPath.row].UserImage! as Data))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NowUser.shared.tapuser = eventUsers[indexPath.row]
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc func postEvent(_ sender: UIButton){
        navigationController?.pushViewController(EventPostViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class EventCustomCell: UITableViewCell {
    
    var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    var eventTextView :UITextView = {
        let textview = UITextView()
        textview.isEditable = false
        return textview
    }()
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let viewHeight10 = self.contentView.frame.height / 10
        let viewWidth22 = self.contentView.frame.width / 22

        self.contentView.addSubview(eventTitleLabel)
        self.contentView.addSubview(eventTextView)
        self.contentView.addSubview(userImage)
        
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewHeight10 * 2).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: viewWidth22 * 1).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -viewWidth22 * 9).isActive = true
        eventTitleLabel.heightAnchor.constraint(equalToConstant: viewHeight10 * 7).isActive = true
        
        eventTextView.translatesAutoresizingMaskIntoConstraints = false
        eventTextView.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor,constant: viewHeight10 * 2).isActive = true
        eventTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: viewWidth22 * 1).isActive = true
        eventTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -viewWidth22 * 8).isActive = true
        eventTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewHeight10 * 2).isActive = true

        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo:contentView.topAnchor, constant: viewHeight10 * 4).isActive = true
        userImage.leadingAnchor.constraint(equalTo: eventTextView.trailingAnchor,constant: viewWidth22 * 1).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: viewWidth22 * 6).isActive = true
        userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewHeight10 * 4).isActive = true
    }
}
