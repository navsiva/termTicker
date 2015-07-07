//
//  TermCollectionViewCell.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-07.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *counterCollectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *termCollectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteCollectionLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateCollectionLabel;
@end
