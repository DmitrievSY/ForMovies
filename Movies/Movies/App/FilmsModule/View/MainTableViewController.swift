// MainTableViewController.swift
// Copyright © RM. All rights reserved.

import UIKit

final class MainTableViewController: UITableViewController {
    // MARK: - Private Property

    private var category: Category?
    private let urlForString =
        "https://api.themoviedb.org/3/movie/popular?api_key=e318d66f1eef01b2c45127e1e13922a7&language=ru-RU"

    // MARK: - Life Cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigCell()
    }

    // MARK: - Private Methods

    private func setConfigCell() {
        title = "Movies"
        tableView.separatorStyle = .none

        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        parsingMovie()
    }

    private func parsingMovie() {
        guard let pageOneURL =
            URL(
                string: urlForString
            )
        else { return }
        URLSession.shared.dataTask(with: pageOneURL) { data, _, error in
            guard error == nil else { return print("Error serialization json") }
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.category = try decoder.decode(Category.self, from: data)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let imageCount = category?.results.count else { return Int() }
        return imageCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }

        guard let films = category else { return UITableViewCell() }

        return cell.configurateCell(films: films, for: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width * 0.65
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = FilmDescriptionTableViewController()
        guard let choosenFilmNumber = category?.results[indexPath.row].id else { return }
        nav.filmNumber = choosenFilmNumber
        navigationController?.pushViewController(nav, animated: true)
    }
}
