//
//  XLRHtml.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "XLRHtml.h"
#import "XLPathQuery.h"
#import "XLRHtmlElement.h"

@interface XLRHtml()
{
    NSData *_htmldata;
    XLPathQuery *_pathQuery;
}

@end

@implementation XLRHtml

- (id) initWithData:(NSData *)theData
{
    if (!(self = [super init])) {
        return nil;
    }
    
    _htmldata = theData;
    
    return self;
}

- (id)initHtmlData:(NSData *)data
{
    return [self initWithData:data];
}

- (NSArray *)searchWithXPathQuery:(NSString *)query
{
    NSArray * detailNodes = nil;
    
    _pathQuery = [XLPathQuery new];
    detailNodes = [_pathQuery performHtmlQuery:query
                                   withDocData:_htmldata];
   
    
    NSMutableArray * elements = [NSMutableArray array];
    for (id node in detailNodes) {
        [elements addObject:[XLRHtmlElement getElementWithNode:node]];
    }
    return elements;
}

@end
