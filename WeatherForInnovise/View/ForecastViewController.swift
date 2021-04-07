//
//  ForecastViewController.swift
//  WeatherForInnovise
//
//  Created by Hellizar on 5.04.21.
//

import UIKit

class ForecastViewController: UIViewController {

    //MARK: - Variables
    private var weatherViewModel: WeatherViewModel!

    //MARK: GUI Variables
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "city"
        return label
    }()

    private let colorLine: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rainbow")
        view.contentMode = .scaleToFill
        return view
    }()

    private let table: UITableView = {
        let table = UITableView()
        table.backgroundColor = .secondarySystemBackground
        table.register(CustomTableViewCell.self,
                       forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        initViews()
        configureTableView()
        callToViewModelForUIUpdate()
    }

    //MARK: - Methods
    func callToViewModelForUIUpdate() {
        self.weatherViewModel = WeatherViewModel()
        weatherViewModel.fetchedModel.bind { [weak self] _ in
            self?.table.reloadData()
        }
    }

    private func configureTableView() {
        table.dataSource = self
        table.delegate = self
    }

    private func initViews() {
        view.addSubviews([headerLabel, colorLine, table])
        makeConstraints()
    }

    private func makeConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.right.equalToSuperview()
        }

        colorLine.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(4)
        }

        table.snp.makeConstraints { make in
            make.top.equalTo(colorLine.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UITableViewDelegate
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Today"
        } else {
            return weatherViewModel.calculateHeaders()[section]
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard !weatherViewModel.arrayForTable.isEmpty else {
            return 0
        }
        return weatherViewModel.countSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !weatherViewModel.arrayForTable.isEmpty else {
            return 0
        }
        return weatherViewModel.calculateNumberOfRowPerSection()[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            fatalError("custom cell not found")}

        guard !weatherViewModel.arrayForTable.isEmpty else {
            return UITableViewCell()
        }

        
        let extra = weatherViewModel.calculateNumberOfRowPerSection()
        switch indexPath.section {
        case 0:
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row])
            return cell
        case 1:
            let extraRows = extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        case 2:
            let extraRows = extra[1] + extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        case 3:
            let extraRows = extra[2] + extra[1] + extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        case 4:
            let extraRows = extra[3] + extra[2] + extra[1] + extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        case 5:
            let extraRows = extra[4] + extra[3] + extra[2] + extra[1] + extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        case 6:
            let extraRows = extra[5] + extra[4] + extra[3] + extra[2] + extra[1] + extra[0]
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row+extraRows])
            return cell
        default:
            cell.configure(withModel: weatherViewModel.arrayForTable[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
