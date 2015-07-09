//
//  TermCollectionViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-07.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "TermCollectionViewController.h"
#import "Term.h"
#import "ViewController.h"
#import "TermCollectionViewCell.h"
#import "SearchHistory.h"
#import "AppDelegate.h"

@interface TermCollectionViewController ()

@property NSMutableArray *terms;

@end

@implementation TermCollectionViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;







- (IBAction)refreshPressed:(UIBarButtonItem *)sender {
    
    
    //queue fifo code here
    
}

-(void)loadPastTerms{
    
    
    
    // adding the core data
    AppDelegate *appDelegate= [[UIApplication sharedApplication]delegate];
    _managedObjectContext= [appDelegate managedObjectContext];
    
    // Grab the data
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
  //  NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    SearchHistory *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
    
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TermCell"];
    
    [self loadPastTerms];
    
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TermCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    SearchHistory *searches= (SearchHistory *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.termCollectionLabel.text= searches.term;
    cell.siteCollectionLabel.text= searches.url;
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd' at 'HH:mm:ss"];
    NSString *formattedTimeStamp = [format stringFromDate:searches.timeStamp];
    
    NSLog(@"%@", formattedTimeStamp);
    [format setDateFormat:formattedTimeStamp];
    cell.dateCollectionLabel.text= formattedTimeStamp;
    
    NSString *countString= [NSString stringWithFormat:@"%d",searches.count];
    cell.counterCollectionLabel.text= countString;

    
    

    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showTermInfo" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"showTermInfo"]){
        
        NSIndexPath *indexPath=[[self.collectionView indexPathsForSelectedItems]objectAtIndex:0];
    
        
        ViewController *destination = segue.destinationViewController;
        
        SearchHistory *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        destination.searchHistory = object;
        destination.managedObjectContext = self.managedObjectContext;

        [[segue destinationViewController] setSearchHistory:object];
        [[segue destinationViewController] setManagedObjectContext:self.managedObjectContext];
        
 

        
        
    }
}



- (NSFetchedResultsController *)fetchedResultsController
{
    

    
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SearchHistory" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"Controller Did Change");
    [self.collectionView reloadData];
}






/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
