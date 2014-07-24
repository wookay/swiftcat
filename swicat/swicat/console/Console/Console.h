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

@interface Console : NSObject
@property (nonatomic,strong) NSMutableDictionary* imageStore;
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

@end
