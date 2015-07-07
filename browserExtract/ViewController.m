//
//  ViewController.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadTerm{
    if(self.term){
        
        self.termTextField.text = self.term.term;
        self.siteTextField.text = self.term.site;
        
    }
        
    
}
    


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTerm];
    
    
 
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
        
        self.term = [[Term alloc] init];
        self.term.site = self.siteTextField.text;
        
        
        
        
        
        self.counterLabel.text = @"0";
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
    
    
    self.term = [[Term alloc] init];
    self.term.term = self.termTextField.text;
    
    
    NSString *formattedTerm = [NSString stringWithFormat:@"\\b%@\\b", self.term.term];
    
    
    

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
