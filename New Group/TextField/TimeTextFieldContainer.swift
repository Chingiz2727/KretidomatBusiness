//
//  TimeTextFieldContainer.swift
//  Kreditomat
//
//  Created by kairzhan on 5/13/21.
//

import InputMask
import UIKit

private enum Constants {
    static let textMask = "[00]:[00]"
    static let placeholder = "00:00"
}

final class TimeTextFieldContainer: RegularTextField {
    
    var TimeText: String {
        guard let fieldText = text else { return "" }
        let text = CaretString(string: fieldText, caretPosition: fieldText.endIndex, caretGravity: .forward(autocomplete: false))
        let extractedValue =
            listener.primaryMask.apply(toText: text).extractedValue
        return extractedValue
    }
    
    var isFilled: Bool = false {
        didSet {
            
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            layer.borderColor = UIColor.primary.cgColor
        }
    }
    
    private let listener = MaskedTextFieldDelegate(primaryFormat: Constants.textMask)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func setValue(time: String) {
        listener.put(text: time, into: self)
    }
    
    private func configureView() {
        configureDelegate()
        configureTextStyle()
        configureColor()
    }
    
    private func configureColor() {
        textColor = UIColor.black
    }
    
    private func configureTextStyle() {
        keyboardType = .numberPad
        font = .systemFont(ofSize: 13)
        placeholder = Constants.placeholder
    }
    
    private func configureDelegate() {
        delegate = listener
        listener.onMaskedTextChangedCallback = { [weak self] _, _, isFilled in
            self?.isFilled = isFilled
        }
    }
    
}
