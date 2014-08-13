//
//  TestClass.m
//  TestApp
//
//  Created by WooKyoung Noh on 2013. 12. 17..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "NSClassExt.h"
#import "UnitTest.h"
#import <UIKit/UIKit.h>

@interface TestClass : NSObject @end


@implementation TestClass

-(void) test_properties {
    assert_equal(@[@"-(void) test_properties ;"], [NSClassExt methodsForClass:TestClass.class]);

//#if TARGET_OS_IPHONE
//    NSArray* properties =@[
//        @"BOOL               _drawsDebugBaselines",
//        @"BOOL               acceptsEmoji",
//        @"BOOL               acceptsFloatingKeyboard",
//        @"BOOL               acceptsSplitKeyboard",
//        @"BOOL               allowsEditingTextAttributes",
//        @"id                 attributedText",
//        @"long long          autocapitalizationType",
//        @"long long          autocorrectionType",
//        @"id                 beginningOfDocument",
//        @"BOOL               clearsOnInsertion",
//        @"BOOL               contentsIsSingleValue",
//        @"unsigned long long dataDetectorTypes",
//        @"BOOL               deferBecomingResponder",
//        @"id                 delegate",
//        @"BOOL               displaySecureTextUsingPlainText",
//        @"BOOL               editable",
//        @"int                emptyContentReturnKeyType",
//        @"BOOL               enablesReturnKeyAutomatically",
//        @"BOOL               enablesReturnKeyOnNonWhiteSpaceContent",
//        @"id                 endOfDocument",
//        @"id                 font",
//        @"BOOL               forceEnableDictation",
//        @"id                 inputAccessoryView",
//        @"id                 inputDelegate",
//        @"id                 inputView",
//        @"id                 insertionPointColor",
//        @"unsigned long long insertionPointWidth",
//        @"BOOL               interactiveTextSelectionDisabled",
//        @"BOOL               isSingleLineDocument",
//        @"long long          keyboardAppearance",
//        @"long long          keyboardType",
//        @"id                 layoutManager",
//        @"BOOL               learnsCorrections",
//        @"id                 linkTextAttributes",
//        @"id                 markedTextRange",
//        @"id                 markedTextStyle",
//        @"BOOL               returnKeyGoesToNextResponder",
//        @"long long          returnKeyType",
//        @"BOOL               secureTextEntry",
//        @"BOOL               selectable",
//        @"NSRange            selectedRange",
//        @"id                 selectedTextRange",
//        @"long long          selectionAffinity",
//        @"id                 selectionBarColor",
//        @"id                 selectionDragDotImage",
//        @"id                 selectionHighlightColor",
//        @"int                shortcutConversionType",
//        @"long long          spellCheckingType",
//        @"BOOL               suppressReturnKeyStyling",
//        @"id                 text",
//        @"long long          textAlignment",
//        @"id                 textColor",
//        @"id                 textContainer",
//        @"UIEdgeInsets       textContainerInset",
//        @"id                 textInputView",
//        @"int                textLoupeVisibility",
//        @"int                textSelectionBehavior",
//        @"id                 textStorage",
//        @"id                 textSuggestionDelegate",
//        @"void*              textTrimmingSet",
//        @"id                 tokenizer",
//        @"id                 typingAttributes",
//                           @"BOOL               useInterfaceLanguageForLocalization"
//    ];
//    assert_equal(properties, [NSClassExt propertiesForClass:UITextView.class]);
//#endif
}

@end
