//
//  CalculatorVC.swift
//  Calc
//
//  Created by Илья Сергеевич on 19.01.2023.
//

import UIKit
import SnapKit
import Combine

class CalculatorVC: UIViewController {
    
    private let vm = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher <Void,Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()

    private lazy var logoViewTapPublisher: AnyPublisher <Void,Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputVew = SplitInputVew()
    
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:[
                           logoView,
                           resultView,
                           billInputView,
                           tipInputView,
                           splitInputVew])
        stack.axis = .vertical
        stack.spacing = 36
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        observe()
    }
    
    private func bind() {
        
        let input = CalculatorVM.Input(billPublisher: billInputView.valuePublisher,
                                       tipPublisher: tipInputView.valuePublisher,
                                       splitPublisher: splitInputVew.valuePublisher,
                                       logoViewTapPublisher: logoViewTapPublisher )
        
        let output = vm.transform(input: input)
        
        output.updateNewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
        
        output.resetCalculatorPublisher.sink { [unowned self ]_ in
            billInputView.reset()
            tipInputView.reset()
            splitInputVew.reset()
            
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 5.0,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logoView.transform = .identity
                }
            }
            
        }.store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            view.endEditing(true)
        }.store(in: &cancellables)
    }
 
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputVew.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }

}

