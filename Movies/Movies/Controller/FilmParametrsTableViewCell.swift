// FilmParametrsTableViewCell.swift
// Copyright © RM. All rights reserved.

import UIKit

final class FilmParametrsTableViewCell: UITableViewCell {
    // MARK: - Static Property

    static let identifier = "FilmParametrsTableViewCell"

    // MARK: - Public Properties

    var budgetLabelText = ""
    var originalTitleLabelText = ""
    var reliseDataLabelText = ""

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

    // MARK: - Private Methods

    private func createOriginalTitleLabel() {
        originalTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        originalTitleLabel.numberOfLines = 0
        originalTitleLabel.textColor = .darkGray
        contentView.addSubview(originalTitleLabel)
    }

    private func createBudgetLabel() {
        budgetLabel.font = UIFont.boldSystemFont(ofSize: 20)
        budgetLabel.numberOfLines = 0
        budgetLabel.textColor = .darkGray
        contentView.addSubview(budgetLabel)
    }

    private func createReliseDataLabel() {
        reliseDataLabel.font = UIFont.boldSystemFont(ofSize: 20)
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
