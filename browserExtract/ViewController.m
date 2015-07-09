//
//  ViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SearchHistory.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadTerm{
    if(self.searchHistory){
        
        self.termTextField.text = self.searchHistory.term;
        self.siteTextField.text = self.searchHistory.url;
        
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
    
    
    
    if (sender !=self.searchButton) return;
    
    if (self.termTextField.text.length > 0 && self.siteTextField.text.length > 0) {
        
        
        if (self.termTextField.text.length && self.siteTextField.text.length){
            self.searchButton.enabled = YES;
        } else (self.searchButton.enabled = NO);
        
        self.counterLabel.text = @"0";
        
        
        self.searchHistory = [NSEntityDescription insertNewObjectForEntityForName:@"SearchHistory" inManagedObjectContext:self.managedObjectContext];
        self.searchHistory.url = self.siteTextField.text;
        self.searchHistory.term= self.termTextField.text;
        
        
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        NSString *formattedTimeStamp = [format stringFromDate:currentDate];
        [format setDateFormat:formattedTimeStamp];
        
        NSLog(@"%@", formattedTimeStamp);
        
        self.searchHistory.timeStamp = currentDate;
        
        
       
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//        NSString *formattedTimeStamp = [format stringFromDate:self.searchHistory.timeStamp];
//        [format setDateFormat:formattedTimeStamp];
        
        
//        NSString *countString= [NSString stringWithFormat:@"%d",self.searchHistory.count];
//        
//        self.counterLabel.text = countString;
//        
//        NSLog(@"%@", countString);
    }
    
    //pass string to webview and
    
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
    
    
    NSString *formattedTerm = [NSString stringWithFormat:@"\\b%@\\b", self.searchHistory.term];
    
    
    

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
    

    
    self.searchHistory.count = countOfWords;
    
    
    
    
    NSError *error1= nil;
    
    if (![_managedObjectContext save:&error1]) {
        // handles error
    }

    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if (sender != self.searchButton) return;
//    if (self.termTextField.text.length > 0 && self.siteTextField.text.length > 0) {
//        
//        self.term = [[Term alloc] init];
//        self.term.site = self.siteTextField.text;
//        self.term.term = self.termTextField.text;
//        
//        self.counterLabel.text = @"0";
//    }
//
//}

@end
