//
//  ZZBarButton.m
//  ZzPark
//
//  Created by 汪 威 on 12-9-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZBarButton.h"

@implementation ZZBarButton
{

}

- (id)initWithTitle:(NSString *)title style:(ZZBarButtonStyle)style target:(id)target action:(SEL)action
{
  self = [self initWithFrame:CGRectMake(0, 0, 44, 32)];
  if (self) {
    switch (style) {
      case ZZBarButtonStyleGray: {
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgGray"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgGray_Highlight"] forState:UIControlStateHighlighted];
        break;
      }
      case ZZBarButtonStyleOrange: {
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgOrange"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgOrange_Highlight"] forState:UIControlStateHighlighted];
        break;
      }
      default: {
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgGray"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"BarButtonBgGray_Highlight"] forState:UIControlStateHighlighted];
        break;
      }
    }

    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.titleLabel.shadowOffset = CGSizeMake(0, 0.8f);
    self.titleLabel.shadowColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
    
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
  }
  return self;
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
