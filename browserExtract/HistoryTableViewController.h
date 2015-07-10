//
//  HistoryTableViewController.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchQuery.h"
#import "SearchResult.h"

@interface HistoryTableViewController : UITableViewController

@property(nonatomic,strong) SearchQuery *query;

@property(nonatomic,strong) SearchResult *result;
@end
