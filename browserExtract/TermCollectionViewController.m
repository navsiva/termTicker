//
//  TermCollectionViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-07.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "TermCollectionViewController.h"
#import "ViewController.h"
#import "TermCollectionViewCell.h"
#import "SearchQuery.h"
#import "AppDelegate.h"
#import "QueueAdditions.h"

@interface TermCollectionViewController ()

@property NSMutableArray *terms;

@end

@implementation TermCollectionViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (IBAction)refreshPressed:(UIBarButtonItem *)sender {
//    
//    ViewController *search= [[ViewController alloc]init];
//    search.searchHistory= [NSEntityDescription insertNewObjectForEntityForName:@"SearchHistory" inManagedObjectContext:self.managedObjectContext];
//    QueueAdditions *queue= [[QueueAdditions alloc]init];
//    queue.queueAdditions= [[NSMutableArray alloc]init];
//    [queue.queueAdditions addObject:search.searchHistory];
//    
//    NSLog(@"%@",queue.queueAdditions);
    
    
    
    
//    NSError *error;
//    NSString *htmlData= [[NSString alloc]initWithContentsOfURL:<#(NSURL *)#> encoding:NSUTF8StringEncoding error:&error];

    
}



-(void)loadPastTerms{
    
    
    
    // adding the core data
    AppDelegate *appDelegate= [[UIApplication sharedApplication]delegate];
    _managedObjectContext= [appDelegate managedObjectContext];
    
    // Grab the data
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];

   
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
    
    SearchQuery *searches= (SearchQuery *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.termCollectionLabel.text= searches.term;
    cell.siteCollectionLabel.text= searches.url;
    // TODO: GET TIMESTAMP AND COUNT
    
    
    
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd' at 'HH:mm:ss"];
    NSString *formattedTimeStamp = [format stringFromDate:searches.timeStamp];
    
//    NSLog(@"%@", formattedTimeStamp);
    [format setDateFormat:formattedTimeStamp];
    cell.dateCollectionLabel.text= formattedTimeStamp;
    
    
    
    // grab all the related SearchResults
    // sort by timeStamp
    // display count of most recent one.
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    
    NSArray *allResults = searches.results.allObjects;
    NSArray *sortedResults = [allResults sortedArrayUsingDescriptors:sortDescriptors];
    
    
    SearchResult *mostRecent = [sortedResults firstObject];

    
    NSString *countString = [NSString stringWithFormat:@"%d", mostRecent.count];
    cell.counterCollectionLabel.text = countString;

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
        
        SearchQuery *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        destination.searchQuery = object;
        destination.managedObjectContext = self.managedObjectContext;

   
        
 

        
        
    }
}



- (NSFetchedResultsController *)fetchedResultsController
{
    

    
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SearchQuery" inManagedObjectContext:self.managedObjectContext];
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
