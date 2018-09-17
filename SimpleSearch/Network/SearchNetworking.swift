//
//  SearchNetworking.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 16/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import Alamofire

enum SearchResultResponse<T,V> {
	case success(T)
	case failure(V)
}

enum SearchResultError: Error {
	case undecodableResponse
	case jsonNotCorrect
	case nextPageNotAvailable
	case searchStringIsNil
	case unknown(Error)
}

enum SearchRequest {
	static func getResult(for searchText: String, pageNumber: Int, completion: @escaping ( (SearchResultResponse<PageResult, SearchResultError>) -> Void)) {
		let params: Parameters = [Constant.queryKey: searchText, Constant.pageKey: pageNumber]
		Alamofire.request(Constant.searchURL, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
			.responseJSON { (response) in
				switch response.result {
				case .success(let value):
					guard let json = value as? Dictionary<String, Any> else {
						completion(.failure(.undecodableResponse))
						return
					}
					guard let pageResult = PageResult(with: json) else {
						completion(.failure(.jsonNotCorrect))
						return
					}
					completion(.success(pageResult))
				case .failure(let error):
					completion(.failure(.unknown(error)))
				}
		}
	}

	// MARK: - Helper
	private enum Constant {
		static let searchURL: URL = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838")!
		static let queryKey: String = "query"
		static let pageKey: String = "page"
	}
}

enum ImageResultResponse<T,V> {
	case success(T)
	case failure(V)
}

enum ImageResultError: Error {
	case noDataReceived
	case undecodableImageData
	case unknown(Error)
}

enum GetImage {
	static func fromRelativePath(_ imagePath: String, completion: @escaping ((ImageResultResponse<UIImage, ImageResultError>) -> Void)) {
		let imageURL = Constant.imageBasePath.appendingPathComponent(imagePath)
		Alamofire.request(imageURL).response { (response) in
			if let error = response.error {
				completion(.failure(.unknown(error)))
				return
			}
			guard let imageData = response.data else {
				completion(.failure(.noDataReceived))
				return
			}
			guard let image = UIImage(data: imageData) else {
				completion(.failure(.undecodableImageData))
				return
			}
			completion(.success(image))
		}
	}

	private enum Constant {
		static let imageBasePath: URL = URL(string: "http://image.tmdb.org/t/p/w92")!
	}
}
