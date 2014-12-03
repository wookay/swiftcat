//
//  ResponseHandler.m
//  TestApp
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "ResponseHandler.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "Logger.h"
#import "Console.h"
#import "NSArrayExt.h"

@interface NSDictionary (JSON)
-(NSString*) toJSON ;
@end

@implementation NSDictionary (JSON)
-(NSString*) toJSON {
    NSMutableArray* ary = [NSMutableArray array];
    for (NSString* key in self) {
        id value = [self objectForKey:key];
        [ary addObject:SWF(@"\"%@\":\"%@\"", key, value)];
    }
    return SWF(@"{%@}", [ary join:COMMA]);
}
@end


@interface ImageDataResponse : HTTPDataResponse
@end
@implementation ImageDataResponse
- (NSDictionary*) httpHeaders {
    return @{ @"Content-Type" : @"image/png",
              @"Connection" : @"close",
              @"Content-Length" : [NSString stringWithFormat:@"%lu", (unsigned long)[data length]]};
}
@end

@interface JSONDataResponse : HTTPDataResponse
@end
@implementation JSONDataResponse
- (NSDictionary*) httpHeaders {
    return @{ @"Content-Type" : @"application/json",
              @"Connection" : @"close",
              @"Content-Length" : [NSString stringWithFormat:@"%lu", (unsigned long)[data length]]};
}
@end


@implementation ResponseHandler

-(NSObject<HTTPResponse>*) httpResponseForMethod:(NSString *)method URI:(NSString *)path {
//    log_info(@"method %@ %@", method, path);
    if ([path isEqualToString:@"/favicon.ico"]) {
        UIImage* image = [Console.sharedInstance favicon];
        NSData* data = UIImagePNGRepresentation(image);
        return [[ImageDataResponse alloc] initWithData:data];
    } else if ([path hasPrefix:SLASH_IMAGE_SLASH]) {
        UIImage* image = [Console.sharedInstance pathToImage:path];
        NSData* data = UIImagePNGRepresentation(image);
        return [[ImageDataResponse alloc] initWithData:data];
    } else if ([path hasPrefix:SLASH_ZERO_X]) {
        NSString* address = [path substringFromIndex:1];
        log_info(@"slash %@", address);
        NSDictionary* dict = [Console.sharedInstance objectInfo:address];
        NSString* json = [dict toJSON];
        NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
        return [[JSONDataResponse alloc] initWithData:data];
        return nil;
    } else {
        NSString* style = @"pre {font-family: courier; font-size: 15pt;} img {border:1px solid black;}";
        NSString* title = @"arccat Console";
        NSString* head = SWF(@"<meta http-equiv='Content-Type' content='text/html;charset=utf-8'><style type='text/css'>%@</style><title>%@</title>", style, title);
        NSString* html = SWF(@"<html><head>%@</head><body>%@</body></html>", head, Console.sharedInstance.targetToHTMLResponse);
		return [[HTTPDataResponse alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]];
	}
	return [super httpResponseForMethod:method URI:path];
}

@end