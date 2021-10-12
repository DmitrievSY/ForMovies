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

    var viewModel: DetailsViewModelProtocol?
    var filmNumber = Int()

    // MARK: - Private Property

    // private var filmDescription: FilmDescription?
    private let descriptionCells: [DescriptionCells] = [.mainDescription, .additionalDescription]

    // MARK: - Life Cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()

        setConfigCell()
    }

    // MARK: - Private Methods

    private func setConfigCell() {
        viewModel?.reloadData = { self.tableView.reloadData() }
        tableView.register(FilmViewCell.self, forCellReuseIdentifier: FilmViewCell.identifier)
        tableView.register(
            FilmParametrsTableViewCell.self,
            forCellReuseIdentifier: FilmParametrsTableViewCell.identifier
        )
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
            cell.filmTitleText = viewModel?.filmDescription?.title ?? "error"
            cell.descriptionTitleText = viewModel?.filmDescription?.overview ?? "error"

            guard let image = viewModel?.filmDescription?.posterPath else { return UITableViewCell() }
            let staticImageAddress = "https://image.tmdb.org/t/p/w500"

            guard let urlImage = URL(string: staticImageAddress + image)
            else { return UITableViewCell() }
            guard let dataImage = try? Data(contentsOf: urlImage) else { return UITableViewCell() }
            DispatchQueue.main.async {
                cell.dataForImage = dataImage
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
            guard let budgetInt = viewModel?.filmDescription?.budget else { return UITableViewCell() }
            guard let originalLabel = viewModel?.filmDescription?.originalTitle else { return UITableViewCell() }
            guard let reliseDate = viewModel?.filmDescription?.releaseDate else { return UITableViewCell() }

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
