//
//  QFSingleDataCenter.h
//  QFAsyncDataCenter
//
//  Created by dqf on 2017/8/26.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define KSingleKey  @"logId"

@interface QFSingleDataCenter : NSObject

+ (QFSingleDataCenter *)share;

- (UIWindow *)rootWindow;
- (UINavigationController *)rootVC;
- (NSString *)showVC;

@end

@interface QFSingleDataCenter (singleData)

- (void)setClass:(NSString *)classKey object:(NSString *)anObject;
- (NSString *)objectForClass:(NSString *)classKey;
- (void)removeClass:(NSString *)classKey key:(NSString *)aKey;
- (void)removeObjectForClass:(NSString *)classKey;

- (NSString *)showVCObject;
- (void)popVC:(UIViewController *)vc;

@end

@interface UIView (singleData)

- (void)setObject:(NSString *)anObject;
- (NSString *)object;
- (void)removeObject;

//#pragma -class key
//
//- (void)setClass:(NSString *)classKey object:(NSString *)anObject;
//- (NSString *)objectForClass:(NSString *)classKey;
//- (void)removeClass:(NSString *)classKey;

@end

@interface UIViewController (singleData)

- (void)setObject:(NSString *)anObject;
- (NSString *)object;
- (void)removeObject;

//#pragma -class key
//
//- (void)setClass:(NSString *)classKey object:(NSString *)anObject;
//- (NSString *)objectForClass:(NSString *)classKey;
//- (void)removeClass:(NSString *)classKey;

@end

@interface NSString (singleData)

- (NSString *(^)(id))append;
- (NSString *(^)(NSString *, NSString *))replace;

@end
