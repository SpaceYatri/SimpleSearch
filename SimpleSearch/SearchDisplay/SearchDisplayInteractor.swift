//
//  SearchDisplayInteractor.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchDisplayRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDisplayPresentable: Presentable {
    weak var listener: SearchDisplayPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDisplayListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDisplayInteractor: PresentableInteractor<SearchDisplayPresentable>, SearchDisplayInteractable, SearchDisplayPresentableListener {

    weak var router: SearchDisplayRouting?
    weak var listener: SearchDisplayListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchDisplayPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
