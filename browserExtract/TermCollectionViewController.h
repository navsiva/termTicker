//
//  TermCollectionViewController.h
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-07.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TermCollectionViewController : UICollectionViewController<NSFetchedResultsControllerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property(nonatomic,strong) NSFetchedResultsController *fetchedResultsController;



@end
