//
//  ZZBarButton.h
//  ZzPark
//
//  Created by 汪 威 on 12-9-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  ZZBarButtonStyleGray,
  ZZBarButtonStyleOrange,
} ZZBarButtonStyle;

@interface ZZBarButton : UIButton

- (id)initWithTitle:(NSString *)title style:(ZZBarButtonStyle)style target:(id)target action:(SEL)action;

@end
