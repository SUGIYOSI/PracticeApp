enum Category{
    case age
    case sex
    case colleage
    case lives
}

//PickerViewを使った時、配列を持ってくる関数
func getPickerViewArray(category: Category) -> [String]{
    var getString = [String]()
    switch category {
    case .age:
        getString = ["18","19","20","21","22","23","24","25","26","27","28","29","30","31","それ以上"]
    case .sex:
        getString = ["男", "女"]
    case .colleage:
        getString = ["新潟大学","新潟県立大学","長岡技術大学","新潟医療福祉大学","新潟薬科大学","新潟星稜大学","新潟国際情報大学","日本歯科大学","新潟工業短期大学","事業創造大学院大学","県立新潟女子短期大学"]
    case .lives:
        getString = ["新潟市", "燕市","三条市","加茂市","五泉市","阿賀野市","新発田市","長岡市","柏崎市","上越市","見拊市"]
    }
    return getString
}


