import UIKit

class BothMatchViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    var users = [User]()
    var matchUsers = [User]()
    let tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        matchUsers.removeAll()
        users.removeAll()
        tabBarController?.tabBar.isHidden = false
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
    
        for reLike in NowUser.shared.nowuser.like {
            for use in users {
                if use.Email == reLike {
                    for reUserLike in use.like{
                        if reUserLike == NowUser.shared.nowuser.Email{
                            matchUsers.append(use)
                        }
                    }
                }
            }
        }
       tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "マッチング完了"
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: viewWidth, height: viewHeight )
        tableView.register(BothMatchCustomCell.self, forCellReuseIdentifier: "BothMatchCustomCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BothMatchCustomCell",for: indexPath as IndexPath) as! BothMatchCustomCell
        cell.userImage.image = UIImage(data: (matchUsers[indexPath.row].UserImage! as Data))
        cell.userEmail.text = matchUsers[indexPath.row].Email
        cell.userName.text = matchUsers[indexPath.row].UserName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NowUser.shared.tapuser = matchUsers[indexPath.row]
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


class BothMatchCustomCell: UITableViewCell {
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let userEmail: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 引数のないコンストラクタみたいなもの。
    // インスタンスが生成されたときに動く関数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let viewHeight10 = self.contentView.frame.height / 10
        let viewWidth22 = self.contentView.frame.width / 22
    
        self.contentView.addSubview(userImage)
        self.contentView.addSubview(userEmail)
        self.contentView.addSubview(userName)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.topAnchor.constraint(equalTo:contentView.topAnchor, constant: viewHeight10 * 2).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: viewWidth22 * 2).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: viewWidth22 * 8).isActive = true
        userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewHeight10 * 2).isActive = true
        
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        userEmail.topAnchor.constraint(equalTo:userImage.topAnchor).isActive = true
        userEmail.leadingAnchor.constraint(equalTo: userImage.trailingAnchor,constant: viewWidth22 * 2).isActive = true
        userEmail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -viewWidth22 * 2).isActive = true
        userEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo:userEmail.bottomAnchor, constant: viewHeight10 * 3).isActive = true
        userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor,constant: viewWidth22 * 3.5).isActive = true
        userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewWidth22 * 3.5).isActive = true
        userName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -viewHeight10 * 2).isActive = true
        
    }
}
