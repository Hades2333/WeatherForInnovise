//
//  ViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController {

    //MARK: - Variables
    private var weatherViewModel: WeatherViewModel!

    //MARK: GUI Variables
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textAlignment = .center
        return label
    }()

    private let colorLine: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rainbow")
        view.contentMode = .scaleToFill
        return view
    }()

    private let grayLine: [UIImageView] = {
        var viewArray = [UIImageView]()
        for _ in 0...1 {
            let view = UIImageView()
            view.backgroundColor = .gray
            view.contentMode = .scaleToFill
            viewArray.append(view)
        }
        return viewArray
    }()

    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()

    private let midStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let secondMidStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    private let horizontalMidStack: [UIStackView] = {
        var stacks = [UIStackView]()
        for _ in 0...1 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stacks.append(stack)
        }
        return stacks
    }()

    private let verticalStackWithImageAndLabel: [UIStackView] = {
        var stacks = [UIStackView]()
        for _ in 0...4 {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .equalCentering
            stack.spacing = 10
            stacks.append(stack)
        }
        return stacks
    }()

    private let littleImages: [UIImageView] = {
        var images = [UIImageView]()
        for _ in 0...4 {
            let imageView = UIImageView()
            imageView.image?.withTintColor(.systemYellow)
            images.append(imageView)
        }
        return images
    }()

    private let littleLabels: [UILabel] = {
        var labels = [UILabel]()
        for _ in 0...4 {
            let label = UILabel()
            labels.append(label)
        }
        return labels
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self,
                         action: #selector(shareTapped),
                         for: .touchUpInside)
        return button
    }()

    private let bigImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.max")
        view.tintColor = .systemYellow
        return view
    }()

    private let placeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    private let stackForOnline: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()

    private let online: [UIImageView] = {
        var views = [UIImageView]()
        let view1 = UIImageView()
        view1.image = UIImage(named: "online")
        views.append(view1)
        let view2 = UIImageView()
        views.append(view2)
        return views
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        initViews()
        callToViewModelForUIUpdate()
    }

    //MARK: - Methods
    func callToViewModelForUIUpdate() {
        self.weatherViewModel = WeatherViewModel()
        weatherViewModel.fetchedModel.bind { [weak self] _ in

            self?.bigImage.image = self?.weatherViewModel.setMainImage()
            self?.placeLabel.text = self?.weatherViewModel.setPlaceLabel()
            self?.temperatureLabel.text = self?.weatherViewModel.setTemperatureLabel()

            for index in 0...4 {
                self?.littleImages[index].image = self?.weatherViewModel.setLittleImage(withIndex: index)
            }
            for index in 0...4 {
                self?.littleLabels[index].text = self?.weatherViewModel.setLittleLabel(withIndex: index)
            }
        }
    }

    @objc func shareTapped() {
        guard let myMessage = weatherViewModel.weatherMessage else {
            let alert = UIAlertController(title: "Weather info",
                                          message: "nothing to show",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            return
        }

        let alert = UIAlertController(title: "Weather info",
                                      message: myMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }

    private func initViews() {
        view.addSubviews([headerLabel, colorLine, mainStack])
        mainStack.addArrangedSubviews([topStack, midStack, shareButton])
        topStack.addArrangedSubviews([bigImage, stackForOnline, temperatureLabel])
        stackForOnline.addArrangedSubviews([online[0], placeLabel, online[1]])
        midStack.addArrangedSubviews([grayLine[0], secondMidStack, grayLine[1]])
        secondMidStack.addArrangedSubviews([horizontalMidStack[0], horizontalMidStack[1]])
        horizontalMidStack[0].addArrangedSubviews([verticalStackWithImageAndLabel[0],
                                                   verticalStackWithImageAndLabel[1],
                                                   verticalStackWithImageAndLabel[2]])
        horizontalMidStack[1].addArrangedSubviews([verticalStackWithImageAndLabel[3],
                                                   verticalStackWithImageAndLabel[4]])
        
        for element in 0...4 {
            verticalStackWithImageAndLabel[element].addArrangedSubviews([littleImages[element],
                                                                         littleLabels[element]])
        }
        makeConstraints()
    }

    private func makeConstraints() {
        let myOffset: Int = 10

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(myOffset).labeled("Labeled: headerLabel top")
            make.height.equalTo(myOffset * 2).labeled("Labeled: headerLabel height")
            make.left.right.equalToSuperview().labeled("Labeled: headerLabel left and right")
        }

        colorLine.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(myOffset).labeled("Labeled: colorLine top")
            make.left.right.equalToSuperview().labeled("Labeled: colorLine left and right")
            make.height.equalTo(4).labeled("Labeled: colorLine height")
        }

        mainStack.snp.makeConstraints { make in
            make.top.equalTo(colorLine.snp.bottom).offset(myOffset).labeled("Labeled: mainStack top")
            make.left.right.equalToSuperview().labeled("Labeled: mainStack left and right")
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(myOffset).labeled("Labeled: mainStack bottom")
        }

        topStack.snp.makeConstraints { make in
            make.height.equalTo(mainStack.snp.height).multipliedBy(0.5).labeled("Labeled: topStack height")
        }

        midStack.snp.makeConstraints { make in
            make.height.equalTo(mainStack.snp.height).multipliedBy(0.3).labeled("Labeled: midStack height")
        }

        grayLine[0].snp.makeConstraints { make in
            make.top.equalTo(midStack.snp.top).offset(myOffset).labeled("Labeled: grayLine top")
            make.height.equalTo(2).labeled("Labeled: grayLine height")
            make.centerX.equalTo(view).labeled("Labeled: grayLine centerX")
            make.width.equalTo(view.snp.width).multipliedBy(0.6).labeled("Labeled: grayLine width")
        }

        grayLine[1].snp.makeConstraints { make in
            make.bottom.equalTo(midStack.snp.bottom).labeled("Labeled: secondGrayLine bottom")
            make.height.equalTo(2).labeled("Labeled: secondGrayLine height")
            make.width.equalTo(view.snp.width).multipliedBy(0.6).labeled("Labeled: secondGrayLine width")
        }

        secondMidStack.snp.makeConstraints { make in
            make.left.right.equalTo(midStack).labeled("Labeled: secondMidStack left and right")
            make.top.equalTo(grayLine[0].snp.bottom).labeled("Labeled: secondMidStack top")
            make.bottom.equalTo(grayLine[1].snp.top).labeled("Labeled: secondMidStck bottom")
        }

        horizontalMidStack[0].snp.makeConstraints { make in
            make.top.equalTo(grayLine[0].snp.bottom).offset(myOffset).labeled("Labeled: horizontalMidStack top")
            make.left.right.equalToSuperview().labeled("Labeled: horizontalMidStack left and right")
        }

        horizontalMidStack[1].snp.makeConstraints { make in
            make.bottom.equalTo(grayLine[1].snp.top).offset(-myOffset).labeled("Labeled: secondHorizontalMidStack bottom")
            make.width.equalTo(horizontalMidStack[0].snp.width).multipliedBy(0.66).labeled("Labeled: secondHorizontalMidStack width")
            make.centerX.equalTo(view).labeled("Labeled: secondHorizontalMidStack centerX")
        }

        for element in 0...4 {
            littleImages[element].snp.makeConstraints { make in
                make.top.equalTo(verticalStackWithImageAndLabel[element].snp.top).labeled("Labeled:")
                make.width.equalTo(littleImages[element].snp.height).labeled("Labeled:")
            }
        }

        bigImage.snp.makeConstraints { make in
            make.top.equalTo(topStack).inset(myOffset*2).labeled("Labeled:")
            make.centerX.equalTo(topStack).labeled("Labeled:")
            make.width.height.equalTo(topStack.snp.height).multipliedBy(0.5).labeled("Labeled:")
        }

        stackForOnline.snp.makeConstraints { make in
            make.top.equalTo(bigImage.snp.bottom).offset(myOffset).labeled("Labeled:")
            make.height.equalTo(myOffset*4).labeled("Labeled:")
        }

        online[0].snp.makeConstraints { make in
            make.width.height.equalTo(15).labeled("Labeled:")
        }

        online[1].snp.makeConstraints { make in
            make.width.height.equalTo(15).labeled("Labeled:")
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).labeled("Labeled: temperatureLabel top")
            make.width.equalTo(topStack).labeled("Labeled: temperatureLabel width")
        }
    }
}

