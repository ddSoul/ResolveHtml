//
//  XLRHtmlElement.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "XLRHtmlElement.h"

@interface XLRHtmlElement ()
{
    NSDictionary *_htmlnode;
}
@end

@implementation XLRHtmlElement

- (id) initWithNode:(NSDictionary *) theNode
{
    if (!(self = [super init]))
        return nil;
    
    _htmlnode = theNode;
    
    return self;
}

+ (XLRHtmlElement *) getElementWithNode:(NSDictionary *)node
{
    return [[[self class] alloc] initWithNode:node];
}

- (NSString *)nodeContent
{
    return [_htmlnode objectForKey:@"nodeContent"];
}

- (NSString *)nodeName
{
    return [_htmlnode objectForKey:@"nodeName"];
}

@end
