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

@interface ImageDataResponse : HTTPDataResponse
@end
@implementation ImageDataResponse
- (NSDictionary*) httpHeaders {
    return @{ @"Content-Type" : @"image/png",
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