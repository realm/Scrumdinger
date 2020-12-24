/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI
import RealmSwift

class Components: EmbeddedObject {
    @objc dynamic var red: Double = 0
    @objc dynamic var green: Double = 0
    @objc dynamic var blue: Double = 0
    @objc dynamic var alpha: Double = 0
    
    init(red: Double, green: Double, blue: Double, alpha: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension Color {

    private enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }

    /// A new random color.
    static var random: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1)
    }
    
    var components: Components {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return Components(red: Double(red),
                          green: Double(green),
                          blue: Double(blue),
                          alpha: Double(alpha))
    }

//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let red = try container.decode(Double.self, forKey: .red)
//        let green = try container.decode(Double.self, forKey: .green)
//        let blue = try container.decode(Double.self, forKey: .blue)
//        let alpha = try container.decode(Double.self, forKey: .alpha)
//        self.init(Components(red: red, green: green, blue: blue, alpha: alpha))
//    }
    
    init(_ components: Components) {
        self.init(.sRGB, red: components.red, green: components.green, blue: components.blue, opacity: components.alpha)
    }

//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        let components = self.components
//        try container.encode(components.red, forKey: .red)
//        try container.encode(components.green, forKey: .green)
//        try container.encode(components.blue, forKey: .blue)
//        try container.encode(components.alpha, forKey: .alpha)
//    }

    // MARK: - font colors
    /// This color is either black or white, whichever is more accessible when viewed against the scrum color.
    var accessibleFontColor: Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil)
        return isLightColor(red: red, green: green, blue: blue) ? .black : .white
    }
    
    private func isLightColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> Bool {
        let lightRed = red > 0.65
        let lightGreen = green > 0.65
        let lightBlue = blue > 0.65

        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }
}
