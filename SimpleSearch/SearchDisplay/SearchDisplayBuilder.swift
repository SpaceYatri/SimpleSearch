//
//  SearchDisplayBuilder.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import RIBs

protocol SearchDisplayDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDisplayComponent: Component<SearchDisplayDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDisplayBuildable: Buildable {
    func build(withListener listener: SearchDisplayListener) -> SearchDisplayRouting
}

final class SearchDisplayBuilder: Builder<SearchDisplayDependency>, SearchDisplayBuildable {

    override init(dependency: SearchDisplayDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDisplayListener) -> SearchDisplayRouting {
        let component = SearchDisplayComponent(dependency: dependency)
        let viewController = SearchDisplayViewController()
        let interactor = SearchDisplayInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchDisplayRouter(interactor: interactor, viewController: viewController)
    }
}
