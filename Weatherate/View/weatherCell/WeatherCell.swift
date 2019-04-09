//
//  WeatherCell.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/7/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import AlamofireImage

var CellIdentifierWeather: String = "WeatherCell"
class WeatherCell: BaseCollectionViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var forecast: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell(item: AnyObject) {
        
        forecast = item as? Forecast
        if forecast != nil {
            dateLabel.text = (forecast?.time)!
            tempLabel.text = (forecast?.temp)!
            iconImageView.af_setImage(withURL: URL(string: (forecast?.icon)!)!)
        }
    }
}
