//
//  UIBarButtonItem+Customized.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "UIBarButtonItem+Customized.h"

@implementation UIBarButtonItem (Customized)

- (UIImage *)buttonBackground
{
  return [UIImage imageNamed:@"NavBarBg.png"];
}

- (void)didMoveToSuperview
{
  //iOS5 only
  if ([self respondsToSelector:@selector(setBackgroundImage:forState:forBarMetrics:)])
  {
//    [self setBackgroundImage:[self buttonBackground] forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self buttonBackground] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  }
}

//this doesn't work on iOS5 but is needed for iOS4 and earlier
- (void)drawRect:(CGRect)rect
{
  //draw image
  [[self buttonBackground] drawInRect:rect];
}

@end
