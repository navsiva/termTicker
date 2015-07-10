//
//  ViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "HistoryTableViewController.h"


@interface ViewController ()
@property(nonatomic,strong) SearchResult *searchResult;

@end

@implementation ViewController

-(void)loadTerm{
    if(self.searchQuery){
        
        self.termTextField.text = self.searchQuery.term;
        self.siteTextField.text = self.searchQuery.url;
        
    }
        
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTerm];
//    
    AppDelegate *appDelegate= [[UIApplication sharedApplication]delegate];
    _managedObjectContext= [appDelegate managedObjectContext];
    
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)historyButton:(UIBarButtonItem *)sender {



}


- (IBAction)searchPressed:(id)sender {
    
    //check if there is text and set user input to term object
    
    //self.counterLabel.text = @"0";
    
    
    [self.view endEditing:YES];
    self.searchResult= nil;
    self.counterLabel.text = @"0";
        
    
        
//        self.searchQuery = [NSEntityDescription insertNewObjectForEntityForName:@"SearchHistory" inManagedObjectContext:self.managedObjectContext];
//        self.searchQuery.url = self.siteTextField.text;
//        self.searchQuery.term= self.termTextField.text;
//        
//        
//        NSDate *currentDate = [NSDate date];
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//        NSString *formattedTimeStamp = [format stringFromDate:currentDate];
//        [format setDateFormat:formattedTimeStamp];
//        
//        NSLog(@"%@", formattedTimeStamp);
//        
//        self.searchHistory.timeStamp = currentDate;
        
    
    BOOL equalTerms = [self.searchQuery.term isEqualToString:self.termTextField.text];
    BOOL equalUrls = [self.searchQuery.url isEqualToString:self.siteTextField.text];
    
    
    //pass string to webview and
    
    if(!(equalTerms && equalUrls)){
     
        
        // TODO: check if a query with term == ourterm and url == oururl, if it does exist, use that instead of making a new one.
        
        self.searchQuery =[NSEntityDescription insertNewObjectForEntityForName:@"SearchQuery" inManagedObjectContext:self.managedObjectContext];
        self.searchQuery.term= self.termTextField.text;
        self.searchQuery.url= self.siteTextField.text;
    }
    
    NSString *urlString = self.siteTextField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.webView.delegate = self;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;


}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *plainText = [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerText"];
    NSLog(@"%@", plainText);
    
    
    NSUInteger countOfWords= 0;
    
    //UserInformation *userInput= [[UserInformation alloc]init];
    
    
//    self.searchHistory= [NSEntityDescription insertNewObjectForEntityForName:@"SearchHistory" inManagedObjectContext:self.managedObjectContext];
//    
//    self.searchHistory.term= self.termTextField.text;
    
//    self.term = [[Term alloc] init];
//    self.term.term = self.termTextField.text;
    
    
    NSString *formattedTerm = [NSString stringWithFormat:@"\\b%@\\b", self.searchQuery.term];
    
    
    

    NSError *error= nil;
    
    NSRegularExpression *regex= [NSRegularExpression regularExpressionWithPattern:formattedTerm options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches= [regex matchesInString:plainText options:0 range:NSMakeRange(0, plainText.length)];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange wordRange= [match rangeAtIndex:0];
        NSString *word= [plainText substringWithRange:wordRange];
        ++countOfWords;
        NSLog(@"Found word: %@, count of words: %lu", word,(unsigned long)countOfWords);
        
        NSString *formattedResult = [NSString stringWithFormat:@"%lu", (unsigned long)countOfWords];
        self.counterLabel.text = formattedResult;

      
        
        }
    
    if(!self.searchResult ){
        self.searchResult = [NSEntityDescription insertNewObjectForEntityForName:@"SearchResult" inManagedObjectContext:self.managedObjectContext];
        [self.searchQuery addResultsObject:self.searchResult];
        

        
    }
    //NSLog(@"count of words is %lu", countOfWords);
    
    if (countOfWords < self.searchResult.count ) {
        countOfWords = self.searchResult.count;
        
    }
    
    

    
    self.searchResult.count = countOfWords;
    self.searchResult.timeStamp= [NSDate date];
    self.searchQuery.timeStamp= [NSDate date];
    
    
    
    
    NSError *error1= nil;
    
    if (![_managedObjectContext save:&error1]) {
        // handles error
    }

    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
            if ([[segue identifier] isEqualToString:@"showHistory"]) {
                HistoryTableViewController *destination= segue.destinationViewController;
    
                SearchQuery *object= self.searchQuery;
                destination.query= object;
                
                
    
    
            }
    
}


//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//
//    
//    
//
//    if (!self.searchQuery.timeStamp)
//        
//        //NSURLErrorDomain error -999 on bbc.com
//        
//        [self.managedObjectContext deleteObject:self.searchQuery];
//        self.searchQuery = nil;
//    }
//
//



@end
