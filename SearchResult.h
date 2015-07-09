//
//  SearchResult.h
//  browserExtract
//
//  Created by Arsalan Vakili on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SearchQuery;

@interface SearchResult : NSManagedObject

@property (nonatomic) int16_t count;
@property (nonatomic) NSDate *timeStamp;
@property (nonatomic, retain) SearchQuery *query;

@end
