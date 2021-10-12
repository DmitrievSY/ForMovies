// MovieAPIService.swift
// Copyright © RM. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol {
    func parsingFilms(completion: @escaping (Result<Category?, Error>) -> Void)
    func parsingDescription(filmNumber: Int, completion: @escaping (Result<FilmDescription, Error>) -> Void)
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - enum

    private enum RequestPart: String {
        case scheme = "https"
        case host = "api.themoviedb.org"
        case path = "/3/movie/popular"
        case apiKey = "api_key"
        case apiKeyValue = "e318d66f1eef01b2c45127e1e13922a7"
        case language
        case languageValue = "ru-RU"
        case detailMoviePath = "/3/movie/"
    }

    // MARK: - Internal methods

    func parsingFilms(completion: @escaping (Result<Category?, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = RequestPart.scheme.rawValue
        components.host = RequestPart.host.rawValue
        components.path = RequestPart.path.rawValue
        components.queryItems = [
            URLQueryItem(name: RequestPart.apiKey.rawValue, value: RequestPart.apiKeyValue.rawValue),
            URLQueryItem(name: RequestPart.language.rawValue, value: RequestPart.languageValue.rawValue)
        ]

        guard let url = components.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let films = try decoder.decode(Category.self, from: data)
                completion(.success(films))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func parsingDescription(filmNumber: Int, completion: @escaping (Result<FilmDescription, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = RequestPart.scheme.rawValue
        components.host = RequestPart.host.rawValue
        components.path = String(RequestPart.detailMoviePath.rawValue + String(filmNumber))
        components.queryItems = [
            URLQueryItem(name: RequestPart.apiKey.rawValue, value: RequestPart.apiKeyValue.rawValue),
            URLQueryItem(name: RequestPart.language.rawValue, value: RequestPart.languageValue.rawValue)
        ]

        guard let url = components.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let filmDescription = try decoder.decode(FilmDescription.self, from: data)
                completion(.success(filmDescription))

            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
