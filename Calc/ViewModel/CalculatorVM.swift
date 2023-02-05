//
//  CalculatorVM.swift
//  Calc
//
//  Created by Илья Сергеевич on 20.01.2023.
//

import Foundation
import Combine

class CalculatorVM {
    
    private var cancellables = Set<AnyCancellable>()
    private let audioPlayerSerice: AudioPlayerService
    
    init(audioPlayerSerice: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerSerice = audioPlayerSerice
    }
         
    struct Input {
        let billPublisher: AnyPublisher <Double, Never>
        let tipPublisher: AnyPublisher <Tip, Never>
        let splitPublisher: AnyPublisher <Int, Never>
        let logoViewTapPublisher: AnyPublisher <Void, Never>
    }
    
    struct Output {
        let updateNewPublisher: AnyPublisher <Result, Never>
        let resetCalculatorPublisher: AnyPublisher <Void, Never>
    }

    func transform(input: Input) -> Output {
        
        let resultCalculatorPublisher = input.logoViewTapPublisher
            .handleEvents(receiveOutput: {[unowned self] in
                audioPlayerSerice.playSound()
            }).flatMap{
                return Just($0)
            }.eraseToAnyPublisher()
        
        let updateViewPublisher = Publishers.CombineLatest3(input.billPublisher,
                                                            input.tipPublisher,
                                                            input.splitPublisher)
            .flatMap { [unowned self] (bill, tip, split) -> (Just<Result>) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                
                let result = Result(amountPerPerson: amountPerPerson,
                                    totalBill: totalBill,
                                    totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()
        return Output(updateNewPublisher:updateViewPublisher,
                      resetCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .castom(value: let value):
            return Double(value)
        }
    }
    
}
