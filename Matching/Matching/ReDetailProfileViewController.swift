import UIKit

class ReDetailProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var pickerView = UIPickerView()
    var nowPickerViewCategory: Category = .age
    var getPikerViewString = [String]()
    var users = [User]()
    
    let AgeLabel: UILabel = {
        let label = UILabel()
        label.text = "年齢"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let AgeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.addTarget(self, action: #selector(tapAgeButton(_:)), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    let SexLabel: UILabel = {
        let label = UILabel()
        label.text = "性別"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let SexButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapSexButton(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    let LivesLabel: UILabel = {
        let label = UILabel()
        label.text = "住所"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let LivesButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapLivesButton(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    let ColleageLabel: UILabel = {
        let label = UILabel()
        label.text = "学校"
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let ColleageButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapColleageButton(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    let RegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("再設定完了", for: UIControl.State.normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ReDetailRegisterEvent(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 134/255, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 7, height: 7)
        return button
    }()
    
    var pickerViewinView =  UIView()
    
    let BackPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("戻る", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(tapPickerViewButton(_:)), for: UIControl.Event.touchUpInside)
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
        
        self.navigationItem.title = "詳細プロフィール設定"
        let leftBackButton = UIBarButtonItem(barButtonHiddenItem: .Back, target: self, action: #selector(leftBackButtonClick(sender:)))
        self.navigationItem.leftBarButtonItem = leftBackButton
        
        AgeButton.setTitle(NowUser.shared.nowuser.age, for: UIControl.State.normal)
        SexButton.setTitle(NowUser.shared.nowuser.sex, for: UIControl.State.normal)
        LivesButton.setTitle(NowUser.shared.nowuser.lives, for: UIControl.State.normal)
        ColleageButton.setTitle(NowUser.shared.nowuser.colleage, for: UIControl.State.normal)
        
        pickerViewinView = {
            let view1 = UIView()
            pickerView.backgroundColor = UIColor(red: 0.69, green: 0.93, blue: 0.9, alpha: 1.0)
            pickerView.showsSelectionIndicator = true
            pickerView.delegate = self
            pickerView.dataSource = self
            view1.addSubview(BackPickerButton)
            view1.addSubview(pickerView)
            
            BackPickerButton.translatesAutoresizingMaskIntoConstraints = false
            BackPickerButton.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
            BackPickerButton.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: view8Width * 1).isActive = true
            BackPickerButton.trailingAnchor.constraint(equalTo: view1.leadingAnchor, constant: view8Width * 2).isActive = true
            BackPickerButton.heightAnchor.constraint(equalToConstant: view14Height * 0.6).isActive = true
            
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            pickerView.topAnchor.constraint(equalTo: BackPickerButton.bottomAnchor).isActive = true
            pickerView.widthAnchor.constraint(equalTo: view1.widthAnchor).isActive = true
            pickerView.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
            pickerView.centerXAnchor.constraint(equalTo: view1.centerXAnchor).isActive = true
            
            return view1
        }()
        
        view.addSubview(pickerViewinView)
        view.addSubview(AgeLabel)
        view.addSubview(AgeButton)
        view.addSubview(SexLabel)
        view.addSubview(SexButton)
        view.addSubview(LivesLabel)
        view.addSubview(LivesButton)
        view.addSubview(ColleageLabel)
        view.addSubview(ColleageButton)
        view.addSubview(RegisterButton)
        pickerViewinView.isHidden = true
        
        pickerViewinView.translatesAutoresizingMaskIntoConstraints = false
        pickerViewinView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pickerViewinView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view14Height * 5).isActive = true
        pickerViewinView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        pickerViewinView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        AgeLabel.translatesAutoresizingMaskIntoConstraints = false
        AgeLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: view14Height * 2).isActive = true
        AgeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AgeLabel.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        AgeLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        AgeButton.translatesAutoresizingMaskIntoConstraints = false
        AgeButton.topAnchor.constraint(equalTo: AgeLabel.bottomAnchor,constant: view14Height * 0.3).isActive = true
        AgeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AgeButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        AgeButton.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        SexLabel.translatesAutoresizingMaskIntoConstraints = false
        SexLabel.topAnchor.constraint(equalTo: AgeButton.bottomAnchor,constant: view14Height * 0.5).isActive = true
        SexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SexLabel.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        SexLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        SexButton.translatesAutoresizingMaskIntoConstraints = false
        SexButton.topAnchor.constraint(equalTo: SexLabel.bottomAnchor,constant: view14Height * 0.3).isActive = true
        SexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SexButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        SexButton.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        LivesLabel.translatesAutoresizingMaskIntoConstraints = false
        LivesLabel.topAnchor.constraint(equalTo: SexButton.bottomAnchor,constant: view14Height * 0.5).isActive = true
        LivesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LivesLabel.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        LivesLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        LivesButton.translatesAutoresizingMaskIntoConstraints = false
        LivesButton.topAnchor.constraint(equalTo: LivesLabel.bottomAnchor,constant: view14Height * 0.3).isActive = true
        LivesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LivesButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        LivesButton.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        ColleageLabel.translatesAutoresizingMaskIntoConstraints = false
        ColleageLabel.topAnchor.constraint(equalTo: LivesButton.bottomAnchor,constant: view14Height * 0.5).isActive = true
        ColleageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ColleageLabel.widthAnchor.constraint(equalToConstant: view8Width * 3).isActive = true
        ColleageLabel.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        ColleageButton.translatesAutoresizingMaskIntoConstraints = false
        ColleageButton.topAnchor.constraint(equalTo: ColleageLabel.bottomAnchor,constant: view14Height * 0.3).isActive = true
        ColleageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ColleageButton.widthAnchor.constraint(equalToConstant: view8Width * 5).isActive = true
        ColleageButton.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
        
        RegisterButton.translatesAutoresizingMaskIntoConstraints = false
        RegisterButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view14Height * 1.5).isActive = true
        RegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        RegisterButton.widthAnchor.constraint(equalToConstant: view8Width * 4).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: view14Height * 0.8).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getPikerViewString.count
    }
    
    func pickerView(_ pickerView: UIPickerView , titleForRow row: Int , forComponent component: Int) -> String? {
        return getPikerViewString[row]
    }
    
    func pickerView(_ pickerView: UIPickerView , didSelectRow row: Int , inComponent component: Int) {
        switch nowPickerViewCategory{
        case .age:
            AgeButton.setTitle(getPikerViewString[row], for: UIControl.State.normal)
            NowUser.shared.nowuser.age = getPikerViewString[row]
        case .sex:
            SexButton.setTitle(getPikerViewString[row], for: UIControl.State.normal)
            NowUser.shared.nowuser.sex = getPikerViewString[row]
        case .colleage:
            ColleageButton.setTitle(getPikerViewString[row], for: UIControl.State.normal)
            NowUser.shared.nowuser.colleage = getPikerViewString[row]
        case .lives:
            LivesButton.setTitle(getPikerViewString[row], for: UIControl.State.normal)
            NowUser.shared.nowuser.lives = getPikerViewString[row]
        }
    }
    
    
    @objc func tapAgeButton(_ sender: UIButton){
        pickerViewinView.isHidden = false
        RegisterButton.isHidden = true
        ColleageLabel.isHidden = true
        ColleageButton.isHidden = true
        nowPickerViewCategory = .age
        getPikerViewString = getPickerViewArray(category: nowPickerViewCategory)
        pickerView.reloadAllComponents()
    }
    
    @objc func tapSexButton(_ sender: UIButton){
        pickerViewinView.isHidden = false
        RegisterButton.isHidden = true
        ColleageLabel.isHidden = true
        ColleageButton.isHidden = true
        nowPickerViewCategory = .sex
        getPikerViewString = getPickerViewArray(category: nowPickerViewCategory)
        pickerView.reloadAllComponents()
    }
    
    @objc func tapColleageButton(_ sender: UIButton){
        pickerViewinView.isHidden = false
        RegisterButton.isHidden = true
        ColleageLabel.isHidden = true
        ColleageButton.isHidden = true
        nowPickerViewCategory = .colleage
        getPikerViewString = getPickerViewArray(category: nowPickerViewCategory)
        pickerView.reloadAllComponents()
    }
    
    @objc func tapLivesButton(_ sender: UIButton){
        pickerViewinView.isHidden = false
        RegisterButton.isHidden = true
        ColleageLabel.isHidden = true
        ColleageButton.isHidden = true
        nowPickerViewCategory = .lives
        getPikerViewString = getPickerViewArray(category: nowPickerViewCategory)
        pickerView.reloadAllComponents()
    }
    
    
    
    @objc func tapPickerViewButton(_ sender: UIButton){
        pickerViewinView.isHidden = true
        RegisterButton.isHidden = false
        ColleageLabel.isHidden = false
        ColleageButton.isHidden = false
    }
    
    @objc internal func ReDetailRegisterEvent(_ sender: UIButton){
        let userDefaults = UserDefaults.standard
        if let storedusers = userDefaults.object(forKey: "users") as? Data {
            if let unarchiveusers = NSKeyedUnarchiver.unarchiveObject(with: storedusers) as? [User] {
                users.append(contentsOf: unarchiveusers)
            }
        }
        for use in users {
            if use.Email == NowUser.shared.nowuser.Email{
                use.age = NowUser.shared.nowuser.age
                use.sex = NowUser.shared.nowuser.sex
                use.colleage = NowUser.shared.nowuser.colleage
                use.lives = NowUser.shared.nowuser.lives
            }
        }
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "users")
        userDefault.synchronize()
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc internal func leftBackButtonClick(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}
