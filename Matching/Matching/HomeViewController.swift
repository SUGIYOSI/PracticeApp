import UIKit

class HomeViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    var searchUsers = [User]()
    var user = User()
    var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        LoginCheck()
        searchUsers.removeAll()
        tabBarController?.tabBar.isHidden = false
        
        //検索用のsearchUsersと全てのユーザーを表示するusersをsearchSwichで分ける処理
        if NowUser.shared.searchSwich == false {
            let searchUserDefaults = UserDefaults.standard
            if let storedSearchusers = searchUserDefaults.object(forKey: "searchusers") as? Data {
                if let unarchivesearchusers = NSKeyedUnarchiver.unarchiveObject(with: storedSearchusers) as? [User] {
                    searchUsers.append(contentsOf: unarchivesearchusers)
                }
            }
            NowUser.shared.searchSwich = true
        }else{
            let userDefaults = UserDefaults.standard
            if let storedusers = userDefaults.object(forKey: "users") as? Data {
                if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                    searchUsers.append(contentsOf: unarchiveusers)
                }
            }
            self.navigationItem.title = "検索"
        }
        for (index,searchUse) in searchUsers.enumerated() {
            if searchUse.Email == NowUser.shared.nowuser.Email{
                searchUsers.remove(at: index)
            }
        }
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        let viewHeight100 = self.view.frame.height / 100
        let viewWidth100 = self.view.frame.width / 100
        //NavigationBarの設定
        let searchImageButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"search1"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(Search(_:)))
        self.navigationItem.leftBarButtonItem = searchImageButton
        
        //CollectionViewの設定
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: viewWidth100 * 29, height: viewHeight100 * 20)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.sectionInset = UIEdgeInsets(top: 20,left: viewWidth100 * 14,bottom: 0,right: viewWidth100 * 14)
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        collectionView.register(HomeCustomCell.self, forCellWithReuseIdentifier: "HomeCustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCustomCell", for: indexPath) as! HomeCustomCell
        cell.userNameLabel.text   = searchUsers[indexPath.row].UserName
        cell.userImageView.image  = UIImage(data: (searchUsers[indexPath.row].UserImage! as Data))?.resize(size: CGSize(width: 50, height: 50))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NowUser.shared.tapuser = searchUsers[indexPath.row]
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func LoginCheck(){
        if NowUser.shared.nowuser.Email == nil{
            let nc = UINavigationController(rootViewController: LoginViewController())
            self.present(nc, animated: true, completion: nil)
        }
    }
    
    @objc func Search(_ sender: UIButton){
     self.present(SearchViewController(), animated: true, completion: nil)
    }
}


class HomeCustomCell: UICollectionViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
        contentView.backgroundColor = .white
        
        let viewHeight10 = self.contentView.frame.height / 10
        let viewWidth22 = self.contentView.frame.width / 22
        
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(userNameLabel)
        
        self.selectedBackgroundView = UIView(frame: self.bounds)
        self.selectedBackgroundView?.backgroundColor = .red
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo:contentView.topAnchor,constant: viewHeight10 * 8).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: viewWidth22 * 22).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.topAnchor.constraint(equalTo:contentView.topAnchor).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: viewWidth22 * 22).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: viewHeight10 * 10).isActive = true
    }
}


