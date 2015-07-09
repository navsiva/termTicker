//
//  QueueAdditions.m
//  browserExtract
//
//  Created by Arsalan Vakili on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "QueueAdditions.h"

@implementation QueueAdditions

//Add to the tail of the queue
-(void) enqueue: (id) anObject {
    // Push the item in
    [self.queueAdditions addObject: anObject];
}

// Grab the next item in the queue, if there is one
-(id) dequeue {
    // Set aside a reference to the object to pass back
    id queueObject = nil;
    
    // Do we have any items?
    if ([self.queueAdditions lastObject]) {
        // Pick out the first one
#if !__has_feature(objc_arc)
        queueObject = [[[self.queueAdditions objectAtIndex: 0] retain] autorelease];
#else
        queueObject = [self.queueAdditions objectAtIndex: 0];
#endif
        // Remove it from the queue
        [self.queueAdditions removeObjectAtIndex: 0];
    }
    
    // Pass back the dequeued object, if any
    return queueObject;
}

// Takes a look at an object at a given location
-(id) peek: (int) index {
    // Set aside a reference to the peeked at object
    id peekObject = nil;
    // Do we have any items at all?
    if ([self.queueAdditions lastObject]) {
        // Is this within range?
        if (index < [self.queueAdditions count]) {
            // Get the object at this index
            peekObject = [self.queueAdditions objectAtIndex: index];
        }
    }
    
    // Pass back the peeked at object, if any
    return peekObject;
}

// Let's take a look at the next item to be dequeued
-(id) peekHead {
    // Peek at the next item
    return [self peek: 0];
}

// Let's take a look at the last item to have been added to the queue
-(id) peekTail {
    // Pick out the last item
    return [self.queueAdditions lastObject];
}

// Checks if the queue is empty
-(BOOL) empty {
    return ([self.queueAdditions lastObject] == nil);
}

@end
