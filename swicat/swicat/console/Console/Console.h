//
//  Console.h
//  TestApp
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"
#define SLASH_IMAGE_SLASH           @"/image/"
#define SLASH_IMAGE_SLASH_LENGTH    7
#define SLASH_IMAGE_SLASH_CAPTURE   @"/image/capure.png"
#define ADDRESS_LENGTH              10                      // 0x7918bd30
#define SLASH_ZERO_X                @"/0x"

@interface Console : NSObject
@property (nonatomic,strong) NSMutableDictionary* objectStore;
@property (nonatomic,strong) id target;
@property (nonatomic,strong) HTTPServer *httpServer;

-(NSString*) targetToHTMLResponse ;
-(UIImage*) favicon ;
-(UIImage*) pathToImage:(NSString*)path ;
-(void) startServer:(NSUInteger)port ;
+(void) run ;
+(void) run:(id)ui ;
+(Console*) sharedInstance ;
+(UIViewController*) root ;
+(UIViewController*) top ;
-(NSDictionary*) objectInfo:(NSString*)address ;

@end
