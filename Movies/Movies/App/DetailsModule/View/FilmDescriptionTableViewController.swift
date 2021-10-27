// FilmDescriptionTableViewController.swift
// Copyright © DmitrievSY. All rights reserved.

import UIKit

final class FilmDescriptionTableViewController: UITableViewController {
    // MARK: - Enum

    private enum DescriptionCells {
        case mainDescription
        case additionalDescription
    }

    // MARK: - Public Properties

    var viewModel: DetailsViewModelProtocol?

    // MARK: - Private Property

    private let descriptionCells: [DescriptionCells] = [.mainDescription, .additionalDescription]

    // MARK: - Life Cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()

        setConfigCell()
    }

    // MARK: - Private Method

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
            guard let filmDescription = viewModel?.filmDescription else { return UITableViewCell() }
            return cell.configureCell(filmDescription: filmDescription)

        case .additionalDescription:
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: FilmParametrsTableViewCell.identifier,
                    for: indexPath
                ) as? FilmParametrsTableViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            guard let filmDescription = viewModel?.filmDescription else { return UITableViewCell() }
            return cell.configureCell(filmDescription: filmDescription)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
