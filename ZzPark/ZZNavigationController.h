//
//  ZZNavigationController.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-18.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFMapKit.h"
#import "ZZMainController.h"
#import "ZZMainController+ViewControl.h"

@interface ZZNavigationController : UIViewController<UIActionSheetDelegate>
{
  IBOutlet UIView * addCityPointView;
  
  IBOutlet UITextField * textStartCityPoint;
  IBOutlet UITextField * textEndCityPoint;
  
//  WFCityPoint * startCityPoint;
//  WFCityPoint * endCityPoint;
}

@property (nonatomic, retain) ZZMainController* mainController;

@property (nonatomic, retain) WFCityPoint* startCityPoint;
@property (nonatomic, retain) WFCityPoint* endCityPoint;

- (IBAction)close:(id)sender;
- (IBAction)route:(id)sender;
- (IBAction)swapCityPoint:(id)sender;
- (IBAction)addStart:(id)sender;
- (IBAction)addEnd:(id)sender;

- (IBAction)beBack:(id)sender;

@end
