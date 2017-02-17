//
//  XLRHtmlQuery.m
//  ResolveHtml
//
//  Created by ddSoul on 17/2/16.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "XLRHtmlQuery.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

NSArray *derformXPathQuery(xmlDocPtr doc, NSString *query);
NSDictionary *ddictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult,BOOL parentContent);

NSArray *performHtmlQueryWith(NSData *docment,NSString *query){
    
    xmlDocPtr doc;
    
    /**  load Html docoument */
    
    const char *encoded = [[NSString copy] cStringUsingEncoding:NSUTF8StringEncoding];
    
    doc = htmlReadMemory([docment bytes], (int)[docment length], "", encoded, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
    
    if (doc == NULL) {
        //没有数据
        return nil;
    }
    
    NSArray *result = derformXPathQuery(doc, query);
    
    xmlFree(doc);
    
    return result;
}

NSArray *derformXPathQuery(xmlDocPtr doc, NSString *query)
{
    //定义一个XPATH上下文指针xmlXPathContextPtr context 定义一个XPATH对象指针xmlXPathObjectPtr result
    xmlXPathContextPtr context;
    xmlXPathObjectPtr result;
    
    context = xmlXPathNewContext(doc);
    if (context == NULL) {
        //木有内容
        return nil;
    }
    
    result =  xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], context);
    if(result == NULL) {
        
        NSLog(@"Unable to evaluate XPath.");
        xmlXPathFreeContext(context);
        return nil;
    }
    
    xmlNodeSetPtr nodes = result->nodesetval;
    if (!nodes) {
        NSLog(@"Nodes was nil.");
        xmlXPathFreeObject(result);
        xmlXPathFreeContext(context);
        return nil;
    }
    
    NSMutableArray *resultNodes = [NSMutableArray array];
    for (NSInteger i = 0; i < nodes->nodeNr; i++) {
        NSDictionary *nodeDictionary = ddictionaryForNode(nodes->nodeTab[i], nil,false);
        if (nodeDictionary) {
            [resultNodes addObject:nodeDictionary];
        }
    }
    
    /* Cleanup */
    xmlXPathFreeObject(result);
    xmlXPathFreeContext(context);
    
    return resultNodes;

}


NSDictionary *ddictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult,BOOL parentContent)
{
    NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];
    if (currentNode->name) {
        NSString *currentNodeContent = [NSString stringWithCString:(const char *)currentNode->name
                                                          encoding:NSUTF8StringEncoding];
        resultForNode[@"nodeName"] = currentNodeContent;
    }
    
    xmlChar *nodeContent = xmlNodeGetContent(currentNode);
    if (nodeContent != NULL) {
        NSString *currentNodeContent = [NSString stringWithCString:(const char *)nodeContent
                                                          encoding:NSUTF8StringEncoding];
        if ([resultForNode[@"nodeName"] isEqual:@"text"] && parentResult) {
            if (parentContent) {
                NSCharacterSet *charactersToTrim = [NSCharacterSet whitespaceAndNewlineCharacterSet];
                parentResult[@"nodeContent"] = [currentNodeContent stringByTrimmingCharactersInSet:charactersToTrim];
                /** Memory leak point release, Prevent memory leak */
                xmlFree(nodeContent);
                /** Memory leak point release, Prevent memory leak */
                return nil;
            }
            if (currentNodeContent != nil) {
                resultForNode[@"nodeContent"] = currentNodeContent;
            }
            /** Memory leak point release, Prevent memory leak */
            xmlFree(nodeContent);
            /** Memory leak point release, Prevent memory leak */
            return resultForNode;
        } else {
            resultForNode[@"nodeContent"] = currentNodeContent;
        }
        xmlFree(nodeContent);
    }
    
    xmlAttr *attribute = currentNode->properties;
    if (attribute) {
        NSMutableArray *attributeArray = [NSMutableArray array];
        while (attribute) {
            NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
            NSString *attributeName = [NSString stringWithCString:(const char *)attribute->name
                                                         encoding:NSUTF8StringEncoding];
            if (attributeName) {
                attributeDictionary[@"attributeName"] = attributeName;
            }
            
            if (attribute->children) {
                NSDictionary *childDictionary = ddictionaryForNode(attribute->children, attributeDictionary, true);
                if (childDictionary) {
                    attributeDictionary[@"attributeContent"] = childDictionary;
                }
            }
            
            if ([attributeDictionary count] > 0) {
                [attributeArray addObject:attributeDictionary];
            }
            attribute = attribute->next;
        }
        
        if ([attributeArray count] > 0) {
            resultForNode[@"nodeAttributeArray"] = attributeArray;
        }
    }
    
    xmlNodePtr childNode = currentNode->children;
    if (childNode) {
        NSMutableArray *childContentArray = [NSMutableArray array];
        while (childNode) {
            NSDictionary *childDictionary = ddictionaryForNode(childNode, resultForNode,false);
            if (childDictionary) {
                [childContentArray addObject:childDictionary];
            }
            childNode = childNode->next;
        }
        if ([childContentArray count] > 0) {
            resultForNode[@"nodeChildArray"] = childContentArray;
        }
    }
    
    xmlBufferPtr buffer = xmlBufferCreate();
    xmlNodeDump(buffer, currentNode->doc, currentNode, 0, 0);
    NSString *rawContent = [NSString stringWithCString:(const char *)buffer->content encoding:NSUTF8StringEncoding];
    if (rawContent != nil) {
        resultForNode[@"raw"] = rawContent;
    }
    xmlBufferFree(buffer);
    return resultForNode;
}


