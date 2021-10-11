// FilmsTableViewController.swift
// Copyright © RM. All rights reserved.

import UIKit

final class FilmsTableViewController: UITableViewController {
    // MARK: - Private Property

    private var viewModel: FilmsViewModelProtocol?

    init(viewModel: FilmsViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life Cycle VC

    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigCell()
    }

    // MARK: - Private Methods

    private func setConfigCell() {
        viewModel?.reloadTableData = { self.tableView.reloadData() }
        title = "Movies"
        tableView.separatorStyle = .none

        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filmsCount = viewModel?.films?.results.count else { return Int() }
        return filmsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }

        guard let films = viewModel?.films else { return UITableViewCell() }

        return cell.configurateCell(films: films, for: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width * 0.65
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = FilmDescriptionTableViewController()
        guard let choosenFilmNumber = viewModel?.films?.results[indexPath.row].id else { return }
        nav.filmNumber = choosenFilmNumber
        navigationController?.pushViewController(nav, animated: true)
    }
}
