//
//  ZZTabBar.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-3.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZTabBarDelegate;

@interface ZZTabBar : UIView

@property (nonatomic, retain) id<ZZTabBarDelegate> delegate;

@end

@protocol ZZTabBarDelegate <NSObject>
@required

- (IBAction)touchTabBarButton:(id)sender;

@end