//
//  XLRHtmlElement.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLRHtmlElement : NSObject

/**
 * 节点内容
 */
@property (nonatomic, copy, readonly) NSString *nodeContent;

/**
 * 节点名
 */
@property (nonatomic, copy, readonly) NSString *nodeName;

/**
 * node ——> Element
 *
 * @param node 节点
 * @return Elemnt
 */
+ (XLRHtmlElement *) getElementWithNode:(NSDictionary *)node;

@end
