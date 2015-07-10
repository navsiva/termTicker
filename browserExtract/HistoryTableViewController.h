//
//  HistoryTableViewController.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchQuery.h"

@interface HistoryTableViewController : UITableViewController

@property(nonatomic,strong) SearchQuery *query;
@end
