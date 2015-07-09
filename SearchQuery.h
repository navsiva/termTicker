//
//  SearchQuery.h
//  browserExtract
//
//  Created by Arsalan Vakili on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SearchResult;

@interface SearchQuery : NSManagedObject

@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *results;
@property (nonatomic) NSDate *timeStamp;
@end

@interface SearchQuery (CoreDataGeneratedAccessors)

- (void)addResultsObject:(SearchResult *)value;
- (void)removeResultsObject:(SearchResult *)value;
- (void)addResults:(NSSet *)values;
- (void)removeResults:(NSSet *)values;

@end
