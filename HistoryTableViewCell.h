//
//  HistoryTableViewCell.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *termHistoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteHistoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateHistoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterHistoryLabel;

@end
