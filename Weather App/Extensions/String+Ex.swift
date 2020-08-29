//
//  String+Ex.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension String {
    func returnAsDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension NSMutableAttributedString {
    class func setupString(text: String, description: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: text)
        let descriptionText = NSMutableAttributedString(string: description)
        attributedText.append(descriptionText)
        return attributedText
    }
}

extension NSAttributedString {
    func setLineSpacing(_ spacing: CGFloat) {


        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
      //  return NSAttributedString(attributedString: attributedString)
    }
}
