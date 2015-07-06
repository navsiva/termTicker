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

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPressed:(id)sender {
    
    //check if there is text and set user input to term object
    
    if (sender !=self.searchButton) return;
    
    if (self.siteTextField.text.length > 0) {
        
        self.term = [[Term alloc] init];
        self.term.site = self.siteTextField.text;
    }
    
    //pass string to webview and
    
    NSString *urlString = self.siteTextField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.webView.delegate = self;
    


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
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
