//
//  QueueAdditions.h
//  browserExtract
//
//  Created by Arsalan Vakili on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueueAdditions : NSObject

@property(nonatomic,strong) NSMutableArray *queueAdditions;

-(id)dequeue;
-(void) enqueue:(id)obj;
-(id) peek:(int)index;
-(id) peekHead;
-(id) peekTail;
-(BOOL) empty;

@end
