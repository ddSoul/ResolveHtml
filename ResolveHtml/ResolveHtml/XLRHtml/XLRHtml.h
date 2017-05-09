//
//  XLRHtml.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLRHtml : NSObject

/**
 * 初始化需要操作的网页数据
 *
 * @param data html data
 * @return XLRhtml object
 */
- (id)initHtmlData:(NSData *)data;

/**
 * 执行查询操作
 *
 * @param query 查询条件
 * @return NSArray
 */
- (NSArray *)searchWithXPathQuery:(NSString *)query;

@end
