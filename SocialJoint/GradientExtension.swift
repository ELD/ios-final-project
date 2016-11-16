import UIKit
extension CAGradientLayer {
    
    
    func turquoiseColor() -> CAGradientLayer {
        let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
        let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        return gradientLayer
    }
    
    func WhiteGrayColor() -> CAGradientLayer {
        let topColor = UIColor(red: (113/255.0), green: (113/255.0), blue: (113/255.0), alpha: 1)
        let bottomColor = UIColor(red: (33/255.0), green: (33/255.0), blue: (33/255.0), alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        return gradientLayer
    }
    
    
    func IntroColor() -> CAGradientLayer {
        let topColor = UIColor(red: (44/255.0), green: (166/255.0), blue: (147/255.0), alpha: 1)
        let bottomColor = UIColor(red: (33/255.0), green: (75/255.0), blue: (110/255.0), alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        return gradientLayer
    }
    
    func MainColor() -> CAGradientLayer {
        let topColor = UIColor(red: (95/255.0), green: (148/255.0), blue: (174/255.0), alpha: 1)
        let bottomColor = UIColor(red: (195/255.0), green: (222/255.0), blue: (235/255.0), alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        return gradientLayer
    }
  

    
    
}
