//
//  CalcSnapshotTests.swift
//  CalcTests
//
//  Created by Илья Сергеевич on 21.01.2023.
//

import XCTest
import SnapshotTesting
@testable import Calc

final class сalcSnapshotTests: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }

}
