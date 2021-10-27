// MoviesTableViewCell.swift
// Copyright © DmitrievSY. All rights reserved.

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    // MARK: - Static Property

    static let identifier = "CustomTableViewCell"

    // MARK: - Private Properties

    private let staticImageAddress = "https://image.tmdb.org/t/p/w500"
    private let filmsOverviewLabel = UITextView()
    private let filmsTitleLabel = UILabel()
    private let filmsPosterImageView = UIImageView()
    private let voteLabel = UILabel()
    private let backOverviewView = UIView()
    private let backVoteLabelView = UIView()
    private let imageService = ImageService()

    // MARK: - Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCellView()
    }

    // MARK: - Internal Methods

    func configurateCell(films: [ResultsFilm], for indexPath: IndexPath) -> UITableViewCell {
        filmsOverviewLabel.text = films[indexPath.row].overview
        filmsTitleLabel.text = films[indexPath.row].title
        voteLabel.text = String(films[indexPath.row].voteAverage)
        let imageURLString = films[indexPath.row].posterPath ?? ""

        imageService.getImage(url: imageURLString) { [weak self] image in
            DispatchQueue.main.async {
                self?.filmsPosterImageView.image = image
            }
        }
        return self
    }

    // MARK: - Private Methods

    private func setupCellView() {
        createBackVoteLabelView()
        setBackVoteLabelViewConstraints()
        createVoteLabel()
        setVoteLabelConstraints()
        createOverviewLabelCell()
        createTitleLabelCell()
        createImageCell()
        setImageConstraints()
        setFilmsTitleLableConstraints()
        setFilmsOverviewConstraint()
        createBackOverviewView()
        setBackOverviewViewConstraints()
    }

    private func createBackVoteLabelView() {
        backVoteLabelView.backgroundColor = .systemBlue
        backVoteLabelView.alpha = 0.85
        backVoteLabelView.layer.borderWidth = 1
        backVoteLabelView.clipsToBounds = true
        backVoteLabelView.layer.cornerRadius = 5
        filmsPosterImageView.addSubview(backVoteLabelView)
    }

    private func createVoteLabel() {
        voteLabel.font = UIFont.boldSystemFont(ofSize: 16)
        voteLabel.textColor = .white
        voteLabel.adjustsFontSizeToFitWidth = true
        backVoteLabelView.addSubview(voteLabel)
    }

    private func createBackOverviewView() {
        backOverviewView.backgroundColor = .green
        contentView.addSubview(backOverviewView)
    }

    private func createOverviewLabelCell() {
        filmsOverviewLabel.isScrollEnabled = false
        filmsOverviewLabel.font = UIFont.systemFont(ofSize: 14)
        filmsOverviewLabel.isUserInteractionEnabled = false
        filmsOverviewLabel.backgroundColor = .white
        backOverviewView.addSubview(filmsOverviewLabel)
    }

    private func createTitleLabelCell() {
        filmsTitleLabel.numberOfLines = 0
        filmsTitleLabel.textColor = .darkGray
        filmsTitleLabel.adjustsFontSizeToFitWidth = false
        filmsTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(filmsTitleLabel)
    }

    private func createImageCell() {
        filmsPosterImageView.clipsToBounds = true
        filmsPosterImageView.layer.cornerRadius = 10
        if filmsPosterImageView.image == nil {
            filmsPosterImageView.image = UIImage(named: "poster")
        }
        contentView.addSubview(filmsPosterImageView)
    }

    private func setBackVoteLabelViewConstraints() {
        backVoteLabelView.translatesAutoresizingMaskIntoConstraints = false
        backVoteLabelView.topAnchor.constraint(equalTo: filmsPosterImageView.topAnchor, constant: 10).isActive = true
        backVoteLabelView.leadingAnchor.constraint(equalTo: filmsPosterImageView.leadingAnchor, constant: 10)
            .isActive = true
        backVoteLabelView.widthAnchor.constraint(equalTo: filmsPosterImageView.widthAnchor, multiplier: 0.27)
            .isActive = true
        backVoteLabelView.heightAnchor.constraint(equalTo: backVoteLabelView.widthAnchor, multiplier: 0.5)
            .isActive = true
    }

    private func setVoteLabelConstraints() {
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.centerYAnchor.constraint(equalTo: backVoteLabelView.centerYAnchor).isActive = true
        voteLabel.centerXAnchor.constraint(equalTo: backVoteLabelView.centerXAnchor)
            .isActive = true
    }

    private func setImageConstraints() {
        filmsPosterImageView.translatesAutoresizingMaskIntoConstraints = false
        filmsPosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        filmsPosterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        filmsPosterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        filmsPosterImageView.widthAnchor.constraint(equalTo: filmsPosterImageView.heightAnchor, multiplier: 0.7)
            .isActive = true
    }

    private func setFilmsTitleLableConstraints() {
        filmsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        filmsTitleLabel.topAnchor.constraint(equalTo: filmsPosterImageView.topAnchor).isActive = true
        filmsTitleLabel.leadingAnchor.constraint(equalTo: filmsPosterImageView.trailingAnchor, constant: 15)
            .isActive = true
        filmsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    private func setFilmsOverviewConstraint() {
        filmsOverviewLabel.translatesAutoresizingMaskIntoConstraints = false

        filmsOverviewLabel.leadingAnchor.constraint(equalTo: backOverviewView.leadingAnchor, constant: 0)
            .isActive = true
        filmsOverviewLabel.topAnchor.constraint(equalTo: backOverviewView.topAnchor, constant: 0).isActive = true
        filmsOverviewLabel.bottomAnchor.constraint(equalTo: backOverviewView.bottomAnchor).isActive = true
        filmsOverviewLabel.trailingAnchor.constraint(equalTo: backOverviewView.trailingAnchor, constant: 0)
            .isActive = true
    }

    private func setBackOverviewViewConstraints() {
        backOverviewView.translatesAutoresizingMaskIntoConstraints = false
        backOverviewView.leadingAnchor.constraint(equalTo: filmsPosterImageView.trailingAnchor, constant: 6)
            .isActive = true
        backOverviewView.topAnchor.constraint(equalTo: filmsTitleLabel.bottomAnchor, constant: 0).isActive = true
        backOverviewView.bottomAnchor.constraint(equalTo: filmsPosterImageView.bottomAnchor).isActive = true
        backOverviewView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
    }
}
