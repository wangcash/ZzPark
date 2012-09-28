//
//  ZZNavigationController.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-18.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZNavigationController.h"
#import "ZZBarButton.h"

@implementation ZZNavigationController
{
  BOOL selectingStart;
  BOOL selectingEnd;
}

@synthesize mainController;
@synthesize startCityPoint, endCityPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self setNavigationBar];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)setNavigationBar
{
  [self.navigationItem setTitle:@"导航"];
  
  /* leftBarButton:取消 */
  ZZBarButton *closeButton = [[ZZBarButton alloc] initWithTitle:@"取消"
                                                          style:ZZBarButtonStyleGray
                                                         target:self
                                                         action:@selector(close:)];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:closeButton]];
  [closeButton release];
  
  /* rightBarButton:路线 */
  ZZBarButton *routeButton = [[ZZBarButton alloc] initWithTitle:@"路线"
                                                          style:ZZBarButtonStyleGray
                                                         target:self
                                                         action:@selector(route:)];
  [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:routeButton]];
  [routeButton release];
  
}

- (IBAction)close:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)route:(id)sender
{
  [self.mainController showRouteFromCityPoint:self.startCityPoint toCityPoint:self.endCityPoint];
  [self close:nil];
}

- (IBAction)swapCityPoint:(id)sender
{
  //交换起终点CityPoint
  WFCityPoint *tempCityPoint = self.startCityPoint;
  self.startCityPoint = self.endCityPoint;
  self.endCityPoint = tempCityPoint;
  
  //交换起终点文本内容
  NSString *tempText = textStartCityPoint.text;
  textStartCityPoint.text = textEndCityPoint.text;
  textEndCityPoint.text = tempText;
  
  //如果有这交换焦点位置
  if ([textStartCityPoint isFirstResponder]) {
    [textEndCityPoint becomeFirstResponder];
  }
  else if ([textEndCityPoint isFirstResponder]) {
    [textStartCityPoint becomeFirstResponder];
  }
}

- (IBAction)addStart:(id)sender
{
  selectingStart = YES;
  [self showSelectMenu];
}

- (IBAction)addEnd:(id)sender
{
  selectingEnd = YES;
  [self showSelectMenu];
}

- (void)showSelectMenu
{
  //TODO:隐藏键盘
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"当前位置", @"地图点选", nil];
	[action showInView:self.view];
	[action release];
}

// 菜单选项
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0: {
      if (selectingStart) {
        self.startCityPoint = [WFLocationManager sharedInstance].currentCityPoint;
        textStartCityPoint.text = @"当前位置";
      }
      if (selectingEnd) {
        self.endCityPoint = [WFLocationManager sharedInstance].currentCityPoint;
        textEndCityPoint.text = @"当前位置";
      }
      selectingStart = NO;
      selectingEnd   = NO;
			break;
    }
		case 1: {
      [self.view setHidden:YES];
      NSString *title = nil;
      if (selectingStart) {
        title = @"选择起点";
      }
      if (selectingEnd) {
        title = @"选择终点";
      }
      [self.mainController pushNavItemToSelectPoint:title
                                         backTarget:self
                                         backAction:@selector(beBack:)
                                      pointReceiver:@selector(receiveCityPoint:title:)];
			break;
    }
		default: {
      selectingStart = NO;
      selectingEnd   = NO;
			break;
    }
	}

}

- (IBAction)beBack:(id)sender
{
  [self.view setHidden:NO];
  selectingStart = NO;
  selectingEnd   = NO;
  
  [self.mainController popNavItem];
}

- (void)receiveCityPoint:(WFCityPoint *)cityPoint title:(NSString *)title
{
  if (selectingStart) {
    self.startCityPoint = cityPoint;
    textStartCityPoint.text = title;
  }
  if (selectingEnd) {
    self.endCityPoint = cityPoint;
    textEndCityPoint.text = title;
  }
  
  [self beBack:nil];
}

@end
