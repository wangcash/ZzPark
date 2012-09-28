//
//  UINavigationBar+Customized.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-2.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "UINavigationBar+Customized.h"

@implementation UINavigationBar (Customized)

- (UIImage *)barBackground
{
  return [UIImage imageNamed:@"NavBarBg.png"];
}

- (void)didMoveToSuperview
{
  //iOS5 only
  if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
  {
    [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
  }
}

//this doesn't work on iOS5 but is needed for iOS4 and earlier
- (void)drawRect:(CGRect)rect
{
  //draw image
  [[self barBackground] drawInRect:rect];
}

@end
