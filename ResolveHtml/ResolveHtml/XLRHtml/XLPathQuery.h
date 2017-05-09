//
//  XLPathQuery.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/17.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLPathQuery : NSObject

/**
 * 解析方法
 *
 * @param query 查询条件
 * @param document 文档流
 * @return result
 */
- (NSArray *)performHtmlQuery:(NSString *)query withDocData:(NSData *)document;

@end
