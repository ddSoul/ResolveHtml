//
//  RHViewController.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "RHViewController.h"

#import "TFHpple.h"
#import "XLRHtml.h"
#import "XPathQuery.h"
#import "TFHppleElement.h"
#import "XLRHtmlElement.h"

@interface RHViewController ()

@end

@implementation RHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xl_resolveHtml:@"http://www.jianshu.com/u/4a62c2dce089"];
}

- (void)xl_resolveHtml:(NSString *)urlString
{
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    XLRHtml *reObj = [[XLRHtml alloc] initHtmlData:data];
    
    NSArray *dataArr = [reObj searchWithXPathQuery:@"//p"];
    
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
