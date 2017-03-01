//
//  RHViewController.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "RHViewController.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "XLRHtml.h"
#import "XLRHtmlElement.h"

@interface RHViewController ()

@end

@implementation RHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)test
{
    
    NSString *url = @"http://www.jianshu.com/c/154657b0eac9";
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    XLRHtml *reObj = [[XLRHtml alloc] initHtmlData:data];
    
    NSArray *dataArr = [reObj searchWithXPathQuery:@"//a"];
    
    for (XLRHtmlElement *element in dataArr) {
        
        NSLog(@"_____%@_____%@",element.nodeName,element.nodeContent);

    }

}
- (void)resolveHtml:(NSString *)htmlUrl
{
    NSString *url = @"http://www.jianshu.com/c/154657b0eac9";
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *dataArr = [xpathParser searchWithXPathQuery:@"//a"];
    
    for (TFHppleElement *element in dataArr) {
        
//        if ([[element objectForKey:@"class"] isEqualToString:@"logo"]) {
//            NSLog(@"%@",element.text);
//            NSArray *array = [element searchWithXPathQuery:@"//img"];
//            NSLog(@"__%@",array);
//            
//        }
        NSLog(@"_____%@",element);
//        if (element.attributes[@"src"]) {
//            NSLog(@"_____%@",element.attributes[@"src"]);
//        }
//        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
