//
//  CustomTableViewCell.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 6.04.21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //MARK: - Properties
    static var identifier = "CustomTableViewCell"

    //MARK: - GUI Variables
    private let weatherImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        view.tintColor = .systemYellow
        return view
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "21:00"
        return label
    }()

    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "sunny"
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "23°"
        return label
    }()

    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()

    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.snp.makeConstraints { make in
            make.height.equalTo(contentView.snp.width).multipliedBy(0.25)
        }

        contentView.addSubviews([weatherImage,
                                 verticalStack,
                                 temperatureLabel])
        verticalStack.addArrangedSubviews([timeLabel, conditionLabel])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()

        let imageSize = contentView.frame.size.width/4

        weatherImage.frame = CGRect(x: 10,
                                    y: 10,
                                    width: imageSize-20,
                                    height: imageSize-20)
        verticalStack.frame = CGRect(x: imageSize+15,
                                     y: 10,
                                     width: imageSize*2,
                                     height: imageSize-20)
        temperatureLabel.frame = CGRect(x: imageSize*3,
                                        y: 0,
                                        width: imageSize,
                                        height: imageSize)
    }

    func configure(withModel model: ForTable) {
        self.weatherImage.image = model.image
        self.timeLabel.text = model.time
        self.conditionLabel.text = model.description
        self.temperatureLabel.text = "\(model.temperature)°"
    }
}
