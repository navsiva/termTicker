//
//  Term.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "Term.h"

@implementation Term

-(instancetype)initWithTerm:(NSString *)term site:(NSString *)site termCounter:(NSInteger *)termCounter{
    self = [super init];
    if(self){
        
        _term = term;
        _site = site;
        _termCounter = termCounter;
        
    }
    
    return self;
}

@end
