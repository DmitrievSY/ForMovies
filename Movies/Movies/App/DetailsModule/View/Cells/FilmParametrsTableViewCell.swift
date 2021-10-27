// FilmParametrsTableViewCell.swift
// Copyright © DmitrievSY. All rights reserved.

import UIKit

final class FilmParametrsTableViewCell: UITableViewCell {
    enum LabelDescriptions: String {
        case budget = "Бюджет:\n"
        case originaleTitle = "Оригинальное название:\n"
        case reliseDate = "Дата релиза:\n"
    }

    // MARK: - Static Property

    static let identifier = "FilmParametrsTableViewCell"

    // MARK: - Private Propertyes

    private let budgetLabel = UILabel()
    private let originalTitleLabel = UILabel()
    private let reliseDataLabel = UILabel()

    // MARK: - Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        createBudgetLabel()
        setBudgetLabelConstraint()

        createOriginalTitleLabel()
        setOriginalTitleLabelConstraint()

        createReliseDataLabel()
        setReliseDataLabelConstraint()
    }

    func configureCell(filmDescription: FilmDescription) -> UITableViewCell {
        guard
            let originalLabel = filmDescription.originalTitle,
            let reliseDate = filmDescription.releaseDate else { return UITableViewCell() }

        budgetLabel.text = String(LabelDescriptions.budget.rawValue + String(filmDescription.budget) + "$")
        originalTitleLabel.text = String(LabelDescriptions.originaleTitle.rawValue + originalLabel)
        reliseDataLabel.text = String(LabelDescriptions.reliseDate.rawValue + reliseDate)
        return self
    }

    // MARK: - Private Methods

    private func createOriginalTitleLabel() {
        originalTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        originalTitleLabel.numberOfLines = 0
        originalTitleLabel.textColor = .darkGray
        contentView.addSubview(originalTitleLabel)
    }

    private func createBudgetLabel() {
        budgetLabel.font = UIFont.boldSystemFont(ofSize: 18)
        budgetLabel.numberOfLines = 0
        budgetLabel.textColor = .darkGray
        contentView.addSubview(budgetLabel)
    }

    private func createReliseDataLabel() {
        reliseDataLabel.font = UIFont.boldSystemFont(ofSize: 18)
        reliseDataLabel.numberOfLines = 0
        reliseDataLabel.textColor = .darkGray
        contentView.addSubview(reliseDataLabel)
    }

    private func setBudgetLabelConstraint() {
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        budgetLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        budgetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    }

    private func setOriginalTitleLabelConstraint() {
        originalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        originalTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        originalTitleLabel.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: 15).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    }

    private func setReliseDataLabelConstraint() {
        reliseDataLabel.translatesAutoresizingMaskIntoConstraints = false
        reliseDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        reliseDataLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 15).isActive = true
        reliseDataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        reliseDataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
}
