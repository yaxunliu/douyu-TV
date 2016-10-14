//
//  ViewController.m
//  test
//
//  Created by 刘亚勋 on 2016/10/13.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.webView loadHTMLString:@"<p>hello world</p>" baseURL:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
