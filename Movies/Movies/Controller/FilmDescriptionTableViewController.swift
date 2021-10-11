// FilmDescriptionTableViewController.swift
// Copyright © RM. All rights reserved.

import UIKit

final class FilmDescriptionTableViewController: UITableViewController {
    // MARK: - Enum

    enum DescriptionCells {
        case mainDescription
        case additionalDescription
    }

    // MARK: - Public Properties

    var filmNumber = Int()

    // MARK: - Private Property

    private var filmDescription: FilmDescription?
    private let descriptionCells: [DescriptionCells] = [.mainDescription, .additionalDescription]

    // MARK: - Life Cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigCell()
    }

    // MARK: - Private Methods

    private func setConfigCell() {
        parsingDescription()
        tableView.register(FilmViewCell.self, forCellReuseIdentifier: FilmViewCell.identifier)
        tableView.register(
            FilmParametrsTableViewCell.self,
            forCellReuseIdentifier: FilmParametrsTableViewCell.identifier
        )
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

    private func parsingDescription() {
        guard let pageDescriptionURL =
            URL(
                string: "https://api.themoviedb.org/3/movie/\(filmNumber)?api_key=e318d66f1eef01b2c45127e1e13922a7&language=ru-RU"
            )
        else { return }

        URLSession.shared.dataTask(with: pageDescriptionURL) { [weak self] data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self?.filmDescription = try decoder.decode(FilmDescription.self, from: data)

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print("error")
            }
        }.resume()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        descriptionCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch descriptionCells[indexPath.row] {
        case .mainDescription:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: FilmViewCell.identifier, for: indexPath) as? FilmViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.filmTitleText = filmDescription?.title ?? "error"
            cell.descriptionTitleText = filmDescription?.overview ?? "error"

            guard let image = filmDescription?.posterPath else { return UITableViewCell() }
            let staticImageAddress = "https://image.tmdb.org/t/p/w500"

            DispatchQueue.global().async {
                guard let urlImage = URL(string: staticImageAddress + image)
                else { return }
                guard let dataImage = try? Data(contentsOf: urlImage) else { return }
                DispatchQueue.main.async {
                    cell.dataForImage = dataImage
                    tableView.reloadData()
                }
            }
            return cell
        case .additionalDescription:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: FilmParametrsTableViewCell.identifier,
                    for: indexPath
                ) as? FilmParametrsTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            guard let budgetInt = filmDescription?.budget else { return UITableViewCell() }
            guard let originalLabel = filmDescription?.originalTitle else { return UITableViewCell() }
            guard let reliseDate = filmDescription?.releaseDate else { return UITableViewCell() }

            cell.budgetLabelText = "Бюджет:\n \(String(budgetInt))$"
            cell.originalTitleLabelText = "Оригинальное название:\n \(originalLabel)"
            cell.reliseDataLabelText = "Дата релиза:\n \(reliseDate)"
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
