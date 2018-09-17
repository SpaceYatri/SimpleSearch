//
//  SearchResultModel.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 17/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

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
