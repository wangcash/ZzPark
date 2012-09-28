//
//  ZZAppDelegate.h
//  ZzPark
//
//  Created by 汪 威 on 12-7-31.
//  Copyright (c) 2012年 wiseflag.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZMainController;

@interface ZZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ZZMainController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
