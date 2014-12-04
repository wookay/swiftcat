//
//  Console.m
//  TestApp
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "Console.h"
#import "ResponseHandler.h"
#import "Logger.h"
#import "NSArrayExt.h"
#import "NSStringExt.h"
#import "UIViewConsoleExt.h"
#import "NSStringConsoleExt.h"
#import "UnitTestUI.h"
#import "objc/message.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>

#define CONSOLE_SERVER_PORT 8080

@interface UIColor (Ext)
-(NSString*) sharpHexRGBA ;
@end

@implementation UIColor (Ext)
-(NSString*) sharpHexRGBA {
    const CGFloat *rgb = CGColorGetComponents(self.CGColor);
    size_t numComponents = CGColorGetNumberOfComponents([self CGColor]);
    if (2 == numComponents) {
        float alpha = rgb[1];
        if (0.0 == alpha) {
            return NSLocalizedString(@"Transparent", nil);
        }
        float red = rgb[0];
        float green = rgb[0];
        float blue = rgb[0];
        int redi = red * 255;
        int greeni = green * 255;
        int bluei = blue * 255;
        NSString* rgba = [NSString stringWithFormat:@"#%02X%02X%02X %.2g", redi, greeni, bluei, alpha];
        return rgba;
    } else {
        float alpha = rgb[3];
        if (0.0 == alpha) {
            return NSLocalizedString(@"Transparent", nil);
        }
        float red = rgb[0];
        float green = rgb[1];
        float blue = rgb[2];
        int redi = red * 255;
        int greeni = green * 255;
        int bluei = blue * 255;
        NSString* rgba = [NSString stringWithFormat:@"#%02X%02X%02X %.2g", redi, greeni, bluei, alpha];
        return rgba;
    }
}
@end


@interface Console ()
-(NSString*) localIPAddress ;
-(UIImage*) objectToImage:(id)obj ;
-(UIImage*) captureImage ;
-(UIView*) statusBar ;
@end

@implementation Console

+(UIViewController*) root {
#ifndef TARGET_IS_EXTENSION
    return UIApplication.sharedApplication.delegate.window.rootViewController;
#else
    return nil;
#endif
}

+(UIViewController*) top {
    id rootVC = self.root;
    if ([rootVC isKindOfClass:UITabBarController.class]) {
        return [[rootVC viewControllers] first];
    } else if ([rootVC isKindOfClass:UINavigationController.class]) {
        return [rootVC topViewController];
    } else {
        return rootVC;
    }
}

-(void) startServer:(NSUInteger)port {
    _httpServer = [[HTTPServer alloc] init];
    _httpServer.port = port;
    _httpServer.type = @"_http._tcp.";
    _httpServer.connectionClass = [ResponseHandler class];
    NSError *error = nil;
    if ([_httpServer start:&error]) {
        log_info(@"Console started  http://%@:%hu", [self localIPAddress], [_httpServer listeningPort]);
    } else {
        log_info(@"Error starting HTTP server %@", error);
    }
    
    _target = Console.root;
    _objectStore = [NSMutableDictionary dictionary];
}

-(NSString*) targetToHTMLResponse {
    NSMutableArray* ary = [NSMutableArray array];
    [ary addObject:@"<pre>"];
    [ary addObject:SWF(@"%@", _target).escapeHTML];
    if ([_target isKindOfClass:[UIViewController class]]) {
        UIViewController* vc = _target;
        [vc.view traverseSubviews:^(int depth, UIView* view) {
            if (nil != view.toImage) {
                NSString* address = SWF(@"%p", view);
                [_objectStore setObject:view forKey:address];
                NSString* viewStr = [view description];
                [ary addObject:SWF(@"%@%@\n", [TABCHAR repeat:depth], viewStr).escapeHTML];
                [ary addObject:SWF(@"<img src='%@%@' title='%@'/>", SLASH_IMAGE_SLASH, address, address)];
            }
        }];
    }
    [ary addObject:@"<hr/>"];
    UIView* statusBar = [self statusBar];
    if (nil != statusBar) {
        NSString* address = SWF(@"%p", statusBar);
        [_objectStore setObject:statusBar forKey:address];
        [ary addObject:SWF(@"%@", statusBar).escapeHTML];
        [ary addObject:SWF(@"<img src='%@%@' title='%@'/>", SLASH_IMAGE_SLASH, address, address)];
    }
#ifndef TARGET_IS_EXTENSION
    for (UIWindow* window in UIApplication.sharedApplication.windows) {
        [ary addObject:SWF(@"%@", window).escapeHTML];
    }
#endif
    [ary addObject:SWF(@"<img src='%@' title='%@'/>", SLASH_IMAGE_SLASH_CAPTURE, SLASH_IMAGE_SLASH_CAPTURE)];
    [ary addObject:@"</pre>"];
    return [ary componentsJoinedByString:@"\n"];
}

-(NSDictionary*) objectInfo:(NSString*)address {
    UIView* view = [_objectStore objectForKey:address];
    if (nil == view) {
        return @{};
    } else {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:view.description forKey:@"description"];
        if ([view respondsToSelector:@selector(backgroundColor)]) {
            if (nil != view.backgroundColor) {
                [dict setObject:view.backgroundColor.description forKey:@"bakgroundColor"];
            }
        }
        return dict;
    }
}

+(void) run {
    [[self sharedInstance] startServer:CONSOLE_SERVER_PORT];
}

+(void) run:(id)ui {
    [UnitTest run:ui];
    [[self sharedInstance] startServer:CONSOLE_SERVER_PORT];
}

-(NSString*) localIPAddress {
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    BOOL success = 0 == getifaddrs(&addrs);
    if (success) {
        cursor = addrs;
        while (NULL != cursor) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) {
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return @"localhost";
}

-(UIImage*) pathToImage:(NSString*)path {
    if (path.length > SLASH_IMAGE_SLASH_LENGTH) {
        if ([SLASH_IMAGE_SLASH_CAPTURE isEqualToString:path]) {
            return [self captureImage];
        } else {
            NSString* address = [path substringWithRange:NSMakeRange(SLASH_IMAGE_SLASH_LENGTH, ADDRESS_LENGTH)];
            UIView* view = [_objectStore objectForKey:address];
            return view.toImage;
        }
    }
    return nil;
}

-(UIView*) statusBar {
#ifndef TARGET_IS_EXTENSION
    if (! CGRectIsEmpty([UIApplication sharedApplication].statusBarFrame)) {
        Class statusBarWindow = NSClassFromString(@"UIStatusBarWindow");
        if (NULL == statusBarWindow) {
        } else {
            UIWindow* statusBarWindow = objc_msgSend(UIApplication.sharedApplication, NSSelectorFromString((@"statusBarWindow")));
            return [statusBarWindow.subviews objectAtIndex:0];
        }
	}
#endif
    return nil;
}

-(UIImage*) objectToImage:(id)obj {
	UIImage* image = nil;
	if ([obj isKindOfClass:[UIView class]]) {
		image = [obj toImage];
	} else if ([obj isKindOfClass:[UIImage class]]) {
		image = obj;
	} else if ([obj isKindOfClass:[CALayer class]]) {
		CALayer* layer = obj;
		UIGraphicsBeginImageContext(layer.frame.size);
		[layer renderInContext: UIGraphicsGetCurrentContext()];
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
	return image;
}

-(UIImage*) captureImage {
#ifndef TARGET_IS_EXTENSION
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, window.opaque, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	for (UIWindow* window in [UIApplication sharedApplication].windows) {
		[window.layer renderInContext:ctx];
	}
    UIView* statusBar = [self statusBar];
    if (nil != statusBar) {
        [statusBar.layer renderInContext:ctx];
    }
#endif
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

-(UIImage*) favicon {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,32,32)];
    label.text = @"arc\ncat";
    label.numberOfLines = 2;
    label.font = [UIFont fontWithName:@"Verdana" size:18];
    label.adjustsFontSizeToFitWidth = true;
    label.textColor = [UIColor yellowColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0.13 green:0.63 blue:0.13 alpha:1];
    return [self objectToImage:label];
}

- (id) init {
    self = [super init];
    if (self) {
        _target = nil;
        _objectStore = nil;
        _httpServer = nil;
    }
    return self;
}

+(Console*) sharedInstance {
    static Console* manager = nil;
    if (!manager) {
        manager = [Console new];
    }
    return manager;
}

@end