//
//  SearchHistory.h
//  browserExtract
//
//  Created by Arsalan Vakili on 2015-07-08.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SearchHistory : NSManagedObject

@property (nonatomic) int16_t count;
@property (nonatomic, retain) NSString * term;
@property (nonatomic) NSDate  *timeStamp;
@property (nonatomic, retain) NSString * url;

@end
