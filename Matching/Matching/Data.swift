import Foundation

class User:NSObject, NSCoding {
    
    var UserName: String?
    var Email: String?
    var Password: String?
    var UserImage: NSData?
    var lives: String?
    var sex: String?
    var age: String?
    var colleage: String?
    var event: String?
    var singleWord: String?
    var eventName: String?
    var like = [String]()
    
    override init() {
    }
    
    //デコード処理
    required init?(coder aDecoder: NSCoder) {
        UserName = aDecoder.decodeObject(forKey: "username") as? String
        Email = aDecoder.decodeObject(forKey: "email") as? String
        Password = aDecoder.decodeObject(forKey: "password") as? String
        UserImage = aDecoder.decodeObject(forKey: "userimage") as? NSData
        lives = aDecoder.decodeObject(forKey: "lives") as? String
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        age = aDecoder.decodeObject(forKey: "age") as? String
        colleage = aDecoder.decodeObject(forKey: "colleage") as? String
        singleWord = aDecoder.decodeObject(forKey: "singleword") as? String
        like = aDecoder.decodeObject(forKey: "like") as! [String]
        event = aDecoder.decodeObject(forKey: "event") as? String
        eventName = aDecoder.decodeObject(forKey: "eventname") as? String
    }
    
    //エンコード処理
    func encode(with aCoder: NSCoder){
        aCoder.encode(UserName, forKey: "username")
        aCoder.encode(Email, forKey: "email")
        aCoder.encode(Password, forKey: "password")
        aCoder.encode(UserImage, forKey: "userimage")
        aCoder.encode(singleWord, forKey: "singleword")
        aCoder.encode(lives, forKey: "lives")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(age,forKey: "age")
        aCoder.encode(colleage, forKey:"colleage")
        aCoder.encode(like, forKey: "like")
        aCoder.encode(event, forKey: "event")
        aCoder.encode(eventName, forKey: "eventname")
    }
}

//現在のユーザーデータと指定している本のデータを格納するシングルトン

final class NowUser{
    static let shared = NowUser()
    var nowuser = User()
    var tapuser = User()
    var tentativeUser = User()
    var searchSwich: Bool = true
    private init() {}
}
