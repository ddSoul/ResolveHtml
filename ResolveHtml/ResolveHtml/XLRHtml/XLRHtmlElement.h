//
//  XLRHtmlElement.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLRHtmlElement : NSObject

@property (nonatomic, copy, readonly) NSString *nodeContent;

@property (nonatomic, copy, readonly) NSString *nodeName;

+ (XLRHtmlElement *) getElementWithNode:(NSDictionary *)node;

@end
