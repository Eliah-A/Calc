//
//  AmountVIew.swift
//  Calc
//
//  Created by Илья Сергеевич on 19.01.2023.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifire: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title,
                           font: ThemeFont.regular(ofSize: 18),
                           textColor: ThemeColor.text,
                           textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text =  NSMutableAttributedString(string: "$0",
                                              attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font : ThemeFont.bold(ofSize: 16)],
                          range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifire
        return label
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init (title: String, textAlignment: NSTextAlignment, amountLabelIdentifire: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifire = amountLabelIdentifire
        super.init(frame: .zero)
        layout()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: "$" + amount.currencyFormatedString,
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)],
                           range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
