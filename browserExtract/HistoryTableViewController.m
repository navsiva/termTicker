//
//  HistoryTableViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-09.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryTableViewCell.h"


@interface HistoryTableViewController ()

@property(nonatomic,strong) NSMutableArray *historyArray;


@end

@implementation HistoryTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView.backgroundColor = [UIColor blackColor];

    
    
    NSArray *array = self.query.results.allObjects;
    
    self.historyArray = [array mutableCopy];
    
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    return self.historyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    [self.historyArray objectAtIndex:indexPath.row];
    
    cell.termHistoryLabel.text= self.query.term;
    cell.siteHistoryLabel.text= self.query.url;
  
//    NSString *countString = [NSString stringWithFormat:@"%@", [self.historyArray objectAtIndex:indexPath.row]];
//    cell.counterHistoryLabel.text = countString;
    
//    NSString *countString = [NSString stringWithFormat:@"%d", self.result.count];
//    cell.counterHistoryLabel.text = [self.historyArray mutableArrayValueForKeyPath:@"count"];
    
    
    
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
//    NSArray *sortDescriptors = @[sortDescriptor];
//    
//    
//    NSArray *allResults = self.query.results.allObjects;
//    NSArray *sortedResults = [allResults sortedArrayUsingDescriptors:sortDescriptors];
    
    
    
    
    
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd' at 'HH:mm:ss"];
//    NSString *formattedTimeStamp = [format stringFromDate:self.query.timeStamp];
//    
//    cell.dateHistoryLabel.text = f
//    cell.counterHistoryLabel.text= countString;
//    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
