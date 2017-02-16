//
//  ViewController.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"http://www.baidu.com";
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *dataArr = [xpathParser searchWithXPathQuery:@"//a"];
    
    for (TFHppleElement *element in dataArr) {
        
        if ([[element objectForKey:@"class"] isEqualToString:@"title"]) {
            NSLog(@"%@",element.text);
            
        }
        
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
