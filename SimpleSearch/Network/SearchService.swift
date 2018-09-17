//
//  SearchService.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import Foundation


class SearchService {

	// TODO: make the class singleton. Conform to a protocol. make modifications in store. Attach ribs
	
	private let store: UserDefaults
	private var searchText: String?
	private var currentPage: Int
	private var totalPages: Int

	typealias SearchCompletionBlock = (SearchResultResponse<[SearchResult?], SearchResultError>) -> Void

	var isNextPageAvailable: Bool {
		return totalPages > currentPage
	}

	init(withStore store: UserDefaults) {
		self.store = store
		currentPage = 1
		totalPages = 1
	}

	func search(text searchText: String, completion: @escaping SearchCompletionBlock) {
		self.searchText = searchText
		self.currentPage = 1
		searchSome(searchText, completion: completion)
	}

	func getNextPage(completion: @escaping SearchCompletionBlock) {
		guard isNextPageAvailable else {
			completion(.failure(.nextPageNotAvailable))
			return
		}
		guard let searchText = searchText else {
			completion(.failure(.searchStringIsNil))
			return
		}
		searchSome(searchText, completion: completion)
	}

	// MARK: - Helper

	private func searchSome(_ searchText: String, completion: @escaping SearchCompletionBlock) {
		SearchRequest.getResult(for: searchText, pageNumber: currentPage) { [weak self] (response) in
			guard let `self` = self else { return }
			switch response {
			case .success(let value):
				self.totalPages = value.totalPages
				self.currentPage = value.pageNumber
				completion(.success(value.searchResults))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
