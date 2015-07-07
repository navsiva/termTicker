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

@interface TermCollectionViewController ()

@property NSMutableArray *terms;

@end

@implementation TermCollectionViewController



-(void)loadPastTerms{
    
    
    Term *term1 = [[Term alloc] initWithTerm:@"Lionel Messi" site:@"http://www.fifa.com" termCounter:0];
    
    self.terms = [[NSMutableArray alloc] init];
    
    [self.terms addObject:term1];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    //load old search history/terms via coredata
    
    [self loadPastTerms];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TermCell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.terms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TermCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Term *term = [self.terms objectAtIndex:indexPath.item];
    cell.termCollectionLabel.text = [term term];
    cell.siteCollectionLabel.text = [term site];
   // cell.counterCollectionLabel.text = [NSString stringWithFormat:@"%lu", (long)[term termCounter]];
    
    // cell.dateCollectionLabel.text = [term timeStamp];

    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"showTermInfo" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"showTermInfo"]){
        
        NSIndexPath *indexPath=[[self.collectionView indexPathsForSelectedItems]objectAtIndex:0];
        
        Term *term = self.terms[indexPath.row];
        
        [[segue destinationViewController]setTerm:term];
        
        
        
    }
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
