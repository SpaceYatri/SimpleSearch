//
//  SearchDisplayViewController.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchDisplayPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchDisplayViewController: UIViewController, SearchDisplayPresentable, SearchDisplayViewControllable {

    weak var listener: SearchDisplayPresentableListener?
}
