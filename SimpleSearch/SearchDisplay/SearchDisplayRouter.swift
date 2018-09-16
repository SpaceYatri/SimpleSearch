//
//  SearchDisplayRouter.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import RIBs

protocol SearchDisplayInteractable: Interactable {
    weak var router: SearchDisplayRouting? { get set }
    weak var listener: SearchDisplayListener? { get set }
}

protocol SearchDisplayViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchDisplayRouter: ViewableRouter<SearchDisplayInteractable, SearchDisplayViewControllable>, SearchDisplayRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchDisplayInteractable, viewController: SearchDisplayViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
