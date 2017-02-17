//
//  XLPathQuery.h
//  ResolveHtml
//
//  Created by ddSoul on 17/2/17.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLPathQuery : NSObject

- (NSArray *)performHtmlQuery:(NSString *)query withDocData:(NSData *)document;

@end
