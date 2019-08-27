//
//  RatingControl.swift
//  mealLog
//
//  Created by Jianli He on 8/6/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: properties
    //
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {updateSeletedButtonStatus()}
    }
    @IBInspectable var starSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet { SetupButton()}
    }
    
    @IBInspectable var starCount : Int = 5 {
        didSet { SetupButton()}
    }
    

    
    //MARK: initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupButton()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        SetupButton()
    }
    
    //MARK: Button action
    @objc func ratingButtonTapped(button:UIButton) {
        
        guard let index=ratingButtons.firstIndex(of: button) else {
            fatalError("serious error happened.")
        }
        let selectedRating=index+1
        if selectedRating==rating {
            rating = 0
        }
        else {
            rating=selectedRating
        }
    }
    
    //MARK: Private method
    private func SetupButton() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of:self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named:"filledStar",in:bundle,compatibleWith: self.traitCollection)
        let highlightedStar=UIImage(named:"highlightedStar",in:bundle,compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.selected,.highlighted] )
            
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
            button.accessibilityLabel="Set \(index+1) star rating."
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for:.touchUpInside)
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateSeletedButtonStatus()
    
    }
    
    private func updateSeletedButtonStatus() {
        let testString="to test"
        
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index<rating
        }
        var testString2=testString
        testString2 += testString
        testString2 += testString
        print(testString2)
    }
}
