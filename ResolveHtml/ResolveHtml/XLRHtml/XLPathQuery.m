
//
//  XLPathQuery.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/17.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "XLPathQuery.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

@implementation XLPathQuery

/** 在文档中查询*/
- (NSArray *)performHtmlQuery:(NSString *)query withDocData:(NSData *)document
{
    xmlDocPtr doc;
    /** load Html docoument*/
    NSString *encoding;
    const char *encoded = [encoding cStringUsingEncoding:NSUTF8StringEncoding];
    
    doc = htmlReadMemory([document bytes], (int)[document length], "", encoded, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
    
    if (doc == NULL) {
        /* 木有东西*/
        return nil;
    }
    
    NSArray *result = [self performXPathQuery:query
                                withXmlDocPtr:doc];
    xmlFree(doc);
    
    return result;
}

- (NSArray *)performXPathQuery:(NSString *)query withXmlDocPtr:(xmlDocPtr)document
{
    /** 定义一个XPATH上下文指针xmlXPathContextPtr context 定义一个XPATH对象指针xmlXPathObjectPtr result*/
   
    xmlXPathContextPtr context;
    xmlXPathObjectPtr result;
    
    context = xmlXPathNewContext(document);
    
    if (context == NULL) {
        return nil;
    }
    
    result = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], context);
    
    if (result == NULL) {
        /** 没有可用的Xpath*/
        xmlXPathFreeContext(context);
        return nil;
    }
    
    xmlNodeSetPtr nodes =  result->nodesetval;
    if (!nodes) {
        /** nodes is nil*/
        xmlXPathFreeContext(context);
        xmlXPathFreeObject(result);
        return nil;
    }
    
    NSMutableArray *resultNodes = @[].mutableCopy;
    for (int i = 0; i<nodes->nodeNr; i++) {
        //
        NSDictionary *nodeDictionary = [self dictionaryForNode:nodes->nodeTab[i]];
        if (nodeDictionary) {
            [resultNodes addObject:nodeDictionary];
        }
    }
    
    xmlXPathFreeContext(context);
    xmlXPathFreeObject(result);
    
    return resultNodes;
}

- (NSDictionary *)dictionaryForNode:(xmlNodePtr)currentNode
{
    /** 容纳结果*/
    NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];
    
    /** nodeName*/
    if (currentNode->name) {
        NSString *curremtNodeContent = [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
        resultForNode[@"nodeName"] = curremtNodeContent;
    }
    
    /** nodeContent*/
    xmlChar *nodeContent = xmlNodeGetContent(currentNode);
    if (nodeContent != NULL) {
        NSString *cureentNodeContent = [NSString stringWithCString:(const char *)nodeContent encoding:NSUTF8StringEncoding];
        resultForNode[@"nodeContent"] = cureentNodeContent;
        xmlFree(nodeContent);
    }
    
    return resultForNode;
}

@end
