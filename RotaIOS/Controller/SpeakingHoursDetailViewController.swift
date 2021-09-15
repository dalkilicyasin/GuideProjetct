//
//  SpeakingHoursDetailViewController.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.09.2021.
//

import UIKit

class SpeakingHoursDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var speakingHoursListInDetailPage : [GetSpeakTimeForMobileResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SpeakingHoursTableViewCell.nib, forCellReuseIdentifier: SpeakingHoursTableViewCell.identifier)
    }
    
    init(tourDetailListInDetailPage : [GetSpeakTimeForMobileResponseModel] ) {
        self.speakingHoursListInDetailPage = tourDetailListInDetailPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SpeakingHoursDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.speakingHoursListInDetailPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SpeakingHoursTableViewCell.identifier) as! SpeakingHoursTableViewCell
        cell.labelGuideName.text = self.speakingHoursListInDetailPage[indexPath.row].guideDesc
        cell.labelHotel.text = self.speakingHoursListInDetailPage[indexPath.row].hotelName
        cell.labelStartDate.text = self.speakingHoursListInDetailPage[indexPath.row].startDate
        cell.labelStartTime.text = self.speakingHoursListInDetailPage[indexPath.row].startTime
        cell.labelSpeakingDays.text = self.speakingHoursListInDetailPage[indexPath.row].days
        cell.labelEndDate.text = self.speakingHoursListInDetailPage[indexPath.row].endDate
        cell.labelEndTime.text = self.speakingHoursListInDetailPage[indexPath.row].endTime
        return cell
    }
}
