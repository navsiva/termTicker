//
//  Term.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Term : NSObject

@property NSString *term;

@property NSString *site;

@property NSInteger *termCounter;

@property NSDate *timeStamp;

-(instancetype)initWithTerm:(NSString *)term site:(NSString *)site termCounter:(NSInteger *)termCounter;



@end
