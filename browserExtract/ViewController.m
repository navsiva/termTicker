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
    
    if (sender !=self.searchButton) return;
    
    if (self.siteTextField.text.length > 0) {
        
        self.term = [[Term alloc] init];
        self.term.site = self.siteTextField.text;
        self.term.term = self.termTextField.text;
    }
    
    NSString *urlString = self.siteTextField.text;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    _webView.delegate = self;
    


}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *plainText = [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerText"];
    NSLog(@"%@", plainText);
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
