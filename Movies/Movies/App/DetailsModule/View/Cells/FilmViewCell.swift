// FilmViewCell.swift
// Copyright © RM. All rights reserved.

import UIKit

final class FilmViewCell: UITableViewCell {
    // MARK: - Static property

    static let identifier = "FilmTableViewCell"

    // MARK: - Private properties

    private let filmTitle = UILabel()
    private let posterImageView = UIImageView()
    private let descriptionTitle = UILabel()
    private let backDescriptionView = UIView()
    private let backPostView = UIView()
    private let imageAPIService = ImageAPIService()

    // MARK: - Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCellView()
    }

    // MARK: - Internal Method

    func configureCell(filmDescription: FilmDescription) -> UITableViewCell {
        filmTitle.text = filmDescription.title
        descriptionTitle.text = filmDescription.overview

        guard let imageString = filmDescription.posterPath else { return UITableViewCell() }

        imageAPIService.imageRequest(stringURL: imageString) { image in
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
        return self
    }

    // MARK: - Private Methods

    private func setupCellView() {
        createFilmTitle()
        createPosterImageView()
        createBackPostView()
        setFilmTitleConstraints()
        setBackPosterViewConstraints()
        setPosterImageConstraints()
        createDescriptionTitle()
        createBackDiscriptionView()
        setDescriptionTitleConstraints()
        setBackDiscriptionViewConstraints()
    }

    private func createBackPostView() {
        backPostView.layer.cornerRadius = 12
        backPostView.clipsToBounds = true
        contentView.addSubview(backPostView)
    }

    private func createFilmTitle() {
        filmTitle.textColor = .darkGray
        filmTitle.font = UIFont.boldSystemFont(ofSize: 30)
        filmTitle.numberOfLines = 0
        filmTitle.adjustsFontSizeToFitWidth = true
        contentView.addSubview(filmTitle)
    }

    private func createPosterImageView() {
        backPostView.addSubview(posterImageView)
    }

    private func createBackDiscriptionView() {
        contentView.addSubview(backDescriptionView)
    }

    private func createDescriptionTitle() {
        descriptionTitle.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionTitle.numberOfLines = 0
        backDescriptionView.addSubview(descriptionTitle)
    }

    private func setFilmTitleConstraints() {
        filmTitle.translatesAutoresizingMaskIntoConstraints = false
        filmTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        filmTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filmTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

    private func setBackPosterViewConstraints() {
        backPostView.translatesAutoresizingMaskIntoConstraints = false

        backPostView.topAnchor.constraint(equalTo: filmTitle.bottomAnchor, constant: 10).isActive = true
        backPostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        backPostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }

    private func setPosterImageConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: backPostView.topAnchor, constant: 0).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: backPostView.trailingAnchor, constant: 0).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: backPostView.leadingAnchor, constant: 0).isActive = true

        posterImageView.bottomAnchor.constraint(equalTo: backPostView.bottomAnchor, constant: 0).isActive = true

        backPostView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4).isActive = true
    }

    private func setDescriptionTitleConstraints() {
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitle.topAnchor.constraint(equalTo: backDescriptionView.topAnchor, constant: 0).isActive = true
        descriptionTitle.trailingAnchor.constraint(equalTo: backDescriptionView.trailingAnchor, constant: 0)
            .isActive = true
        descriptionTitle.leadingAnchor.constraint(equalTo: backDescriptionView.leadingAnchor, constant: 0)
            .isActive = true
        descriptionTitle.bottomAnchor.constraint(equalTo: backDescriptionView.bottomAnchor, constant: 0).isActive = true
    }

    private func setBackDiscriptionViewConstraints() {
        backDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        backDescriptionView.topAnchor.constraint(equalTo: backPostView.bottomAnchor, constant: 20).isActive = true
        backDescriptionView.leadingAnchor.constraint(equalTo: backPostView.leadingAnchor).isActive = true
        backDescriptionView.trailingAnchor.constraint(equalTo: backPostView.trailingAnchor).isActive = true
        backDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
