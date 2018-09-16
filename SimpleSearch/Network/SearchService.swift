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

struct SearchResult {
	// as per requirement, whatever is needed in search result is kept non optional.
	let isVideo: Bool?
	let isAdult: Bool?
	let voteCount: Int?
	let popularity: Double?
	let voteAverage: Double?
	let backdropURLPath: String?
	let originalLanguage: String?

	let id: Int
	let title: String
	let overview: String
	let releaseDate: String
	let posterURLPath: String


	init?(with dictionary: Dictionary<String, Any>) {
		guard let id = dictionary["id"] as? Int,
			let title = dictionary["title"] as? String,
			let overview = dictionary["overview"] as? String,
			let releaseDate = dictionary["release_date"] as? String,
			let posterURLPath = dictionary["poster_path"] as? String else {
				return nil
		}

		self.id = id
		self.title = title
		self.overview = overview
		self.releaseDate = releaseDate
		self.posterURLPath = posterURLPath

		isAdult = dictionary["adult"] as? Bool
		isVideo = dictionary["video"] as? Bool
		voteCount = dictionary["vote_count"] as? Int
		popularity = dictionary["popularity"] as? Double
		voteAverage = dictionary["vote_average"] as? Double
		backdropURLPath = dictionary["backdrop_path"] as? String
		originalLanguage = dictionary["original_language"] as? String
	}
}

struct PageResult {
	let pageNumber: Int
	let totalResults: Int
	let totalPages: Int
	let searchResults: [SearchResult?]

	init?(with dictionary: Dictionary<String, Any>) {
		guard let pageNumber = dictionary["page"] as? Int,
			let totalResults = dictionary["total_results"] as? Int,
			let totalPages = dictionary["total_pages"] as? Int,
			let results = dictionary["results"] as? [Dictionary<String, Any>] else {
				return nil
		}
		self.pageNumber = pageNumber
		self.totalResults = totalResults
		self.totalPages = totalPages
		self.searchResults = results
			.map({ SearchResult(with: $0) })
			.filter({ $0 != nil })
	}
}
