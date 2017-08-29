//
//  QFSingleDataCenter.m
//  QFAsyncDataCenter
//
//  Created by dqf on 2017/8/26.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "QFSingleDataCenter.h"
#import "AppDelegate.h"

@interface QFSingleDataCenter ()
@property (nonatomic) NSMutableDictionary *mutableDict;
@end

@implementation QFSingleDataCenter

- (NSMutableDictionary *)mutableDict {
    if (!_mutableDict) {
        _mutableDict = [NSMutableDictionary dictionary];
    }
    return _mutableDict;
}

+ (QFSingleDataCenter *)share {
    static dispatch_once_t predicate;
    static QFSingleDataCenter *sm;
    dispatch_once(&predicate, ^{
        sm = [[self alloc] init];
    });
    return sm;
}

- (UIWindow *)rootWindow {
    return [UIApplication sharedApplication].delegate.window;
}

- (UINavigationController *)rootVC {
    return (UINavigationController *)[self rootWindow].rootViewController;
}

- (NSString *)showVC {
    return [self getShowVC:[self rootVC].topViewController];
}

- (NSString *)getShowVC:(UIViewController *)objc {
    NSUInteger count = objc.childViewControllers.count;
    for (int i=0; i<count; i++) {
        UIViewController *vc = objc.childViewControllers[i];
        if (vc.isViewLoaded && vc.view.window && !vc.view.hidden) {
            return [self getShowVC:vc];
        }
    }
    return NSStringFromClass([objc class]);
}

@end

@implementation QFSingleDataCenter (singleData)

- (void)setClass:(NSString *)classKey object:(NSString *)anObject {
    [self.mutableDict setObject:anObject forKey:classKey.append(KSingleKey)];
}

- (NSString *)objectForClass:(NSString *)classKey {
    return [self.mutableDict objectForKey:classKey.append(KSingleKey)];
}

- (NSString *)objectForClass:(NSString *)classKey key:(NSString *)aKey {
    return [self.mutableDict objectForKey:classKey.append(aKey)];
}

- (void)removeClass:(NSString *)classKey key:(NSString *)aKey {
    [self.mutableDict removeObjectForKey:classKey.append(aKey)];
}

- (void)removeObjectForClass:(NSString *)classKey {
    for (NSInteger i=self.mutableDict.allKeys.count-1; i>=0; i--) {
        NSString *aKey = self.mutableDict.allKeys[i];
        if ([aKey containsString:classKey]) {
            [self.mutableDict removeObjectForKey:aKey];
        }
    }
}


- (NSString *)showVCObject {
    return [self objectForClass:[self showVC] key:KSingleKey];
}

- (void)popVC:(UIViewController *)vc {
    [self removeObjectForClass:NSStringFromClass([vc class])];
}

@end

@implementation UIView (singleData)

- (void)setObject:(NSString *)anObject {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    [[QFSingleDataCenter share].mutableDict setObject:anObject forKey:key];
}

- (NSString *)object {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    return [[QFSingleDataCenter share].mutableDict objectForKey:key];
}

- (void)removeObject {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    if ([[QFSingleDataCenter share].mutableDict.allKeys containsObject:key]) {
        [[QFSingleDataCenter share].mutableDict removeObjectForKey:key];
    }
}

//#pragma -class key
//
//- (void)setClass:(NSString *)classKey object:(NSString *)anObject {
//    [[QFSingleDataCenter share].mutableDict setObject:anObject forKey:classKey.append(KSingleKey)];
//}
//
//- (NSString *)objectForClass:(NSString *)classKey {
//    return [[QFSingleDataCenter share].mutableDict objectForKey:classKey.append(KSingleKey)];
//}
//
//- (void)removeClass:(NSString *)classKey {
//    [[QFSingleDataCenter share].mutableDict removeObjectForKey:classKey.append(KSingleKey)];
//}

@end

@implementation UIViewController (singleData)

- (void)setObject:(NSString *)anObject {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    [[QFSingleDataCenter share].mutableDict setObject:anObject forKey:key];
}

- (NSString *)object {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    return [[QFSingleDataCenter share].mutableDict objectForKey:key];
}

- (void)removeObject {
    NSString *key = NSStringFromClass([self class]).append(KSingleKey);
    if ([[QFSingleDataCenter share].mutableDict.allKeys containsObject:key]) {
        [[QFSingleDataCenter share].mutableDict removeObjectForKey:key];
    }
}

//#pragma -class key
//
//- (void)setClass:(NSString *)classKey object:(NSString *)anObject {
//    [[QFSingleDataCenter share].mutableDict setObject:anObject forKey:classKey.append(KSingleKey)];
//}
//
//- (NSString *)objectForClass:(NSString *)classKey {
//    return [[QFSingleDataCenter share].mutableDict objectForKey:classKey.append(KSingleKey)];
//}
//
//- (void)removeClass:(NSString *)classKey {
//    [[QFSingleDataCenter share].mutableDict removeObjectForKey:classKey.append(KSingleKey)];
//}

@end

@implementation NSString (singleData)

- (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@%@", self,obj];
    };
}

- (NSString *(^)(NSString *, NSString *))replace {
    return ^NSString *(NSString *org1, NSString *org2) {
        return [self stringByReplacingOccurrencesOfString:org1 withString:org2];
    };
}

@end
