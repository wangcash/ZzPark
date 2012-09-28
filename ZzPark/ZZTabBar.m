//
//  ZZTabBar.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-3.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZTabBar.h"

@implementation ZZTabBar
{
  UIImage * bgImage;
  UIImageView * bgImageView;
  
  UIImage * buttonImage;
  UIImage * buttonImageHighlight;
}

@synthesize delegate;

- (id)init
{
  bgImage = [UIImage imageNamed:@"TailTabBarBg"];
  CGRect newFrame = CGRectMake(0, 356, bgImage.size.width, bgImage.size.height);
  self = [super initWithFrame:newFrame];
  if (self) {
    //背景图片
    bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    [self addSubview:bgImageView];
    [bgImageView release];
    
    /* 1.定位按钮 */
    buttonImage = [UIImage imageNamed:@"BarButtonLocation"];
    buttonImageHighlight = [UIImage imageNamed:@"BarButtonLocation_Highlight"];
    UIButton *buttonLocation = [[UIButton alloc] initWithFrame:CGRectMake(136, 5, buttonImage.size.width, buttonImage.size.height)];
    [buttonLocation setTag:0];
    [buttonLocation setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttonLocation setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [buttonLocation addTarget:self.delegate action:@selector(touchTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonLocation];
    [buttonLocation release];
    
    /* 2.搜索按钮 */
    buttonImage = [UIImage imageNamed:@"BarButtonSearch"];
    buttonImageHighlight = [UIImage imageNamed:@"BarButtonSearch_Highlight"];
    UIButton *buttonSearch = [[UIButton alloc] initWithFrame:CGRectMake(7, 18, buttonImage.size.width, buttonImage.size.height)];
    [buttonSearch setTag:1];
    [buttonSearch setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttonSearch setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [buttonSearch addTarget:self.delegate action:@selector(touchTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonSearch];
    [buttonSearch release];
    
    
    /* 3.导航按钮 */
    buttonImage = [UIImage imageNamed:@"BarButtonNavigation"];
    buttonImageHighlight = [UIImage imageNamed:@"BarButtonNavigation_Highlight"];
    UIButton *buttonNavigation = [[UIButton alloc] initWithFrame:CGRectMake(70, 18, buttonImage.size.width, buttonImage.size.height)];
    [buttonNavigation setTag:2];
    [buttonNavigation setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttonNavigation setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [buttonNavigation addTarget:self.delegate action:@selector(touchTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
//    [buttonNavigation setEnabled:NO];
    [self addSubview:buttonNavigation];
    [buttonNavigation release];
    
    /* 4.车位按钮 */
    buttonImage = [UIImage imageNamed:@"BarButtonFindPark"];
    buttonImageHighlight = [UIImage imageNamed:@"BarButtonFindPark_Highlight"];
    UIButton *buttonFindPark = [[UIButton alloc] initWithFrame:CGRectMake(189, 18, buttonImage.size.width, buttonImage.size.height)];
    [buttonFindPark setTag:3];
    [buttonFindPark setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttonFindPark setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [buttonFindPark addTarget:self.delegate action:@selector(touchTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonFindPark];
    [buttonFindPark release];
    
    /* 5.更多按钮 */
    buttonImage = [UIImage imageNamed:@"BarButtonMore"];
    buttonImageHighlight = [UIImage imageNamed:@"BarButtonMore_Highlight"];
    UIButton *buttonMore = [[UIButton alloc] initWithFrame:CGRectMake(253, 18, buttonImage.size.width, buttonImage.size.height)];
    [buttonMore setTag:4];
    [buttonMore setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [buttonMore setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [buttonMore addTarget:self.delegate action:@selector(touchTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonMore];
    [buttonMore release];
    
    UIImage *numberImage = [UIImage imageNamed:@"m_01.png"];
    UIImageView *number = [[UIImageView alloc] initWithFrame:CGRectMake(230, 16, numberImage.size.width, numberImage.size.height)];
    [number setImage:numberImage];
    [self addSubview:number];
    [number release];
  }
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
