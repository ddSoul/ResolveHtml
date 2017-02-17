//
//  XLRHtml.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLRHtml : NSObject

- (id)initHtmlData:(NSData *)data;

- (NSArray *)searchWithXPathQuery:(NSString *)query;

@end
