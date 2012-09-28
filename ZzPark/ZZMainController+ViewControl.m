//
//  ZZMainController+ViewControl.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZMainController+ViewControl.h"
#import "ZZBarButton.h"

@implementation ZZMainController (ViewControl)

- (void)switchToIndoorNavBar:(NSString *)title
            hasReserveButton:(BOOL)hasReserveButton
{
  [self.navigationItem setTitle:title];
  
  /* leftBarButton:户外 */
  ZZBarButton *switchButton = [[ZZBarButton alloc] initWithTitle:@"户外"
                                                          style:ZZBarButtonStyleGray
                                                         target:self
                                                         action:@selector(switchMap:)];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:switchButton]];
  [switchButton release];
  
  if (hasReserveButton) {
    /* rightBarButton:预订 */
    ZZBarButton *reserveButton = [[ZZBarButton alloc] initWithTitle:@"预订"
                                                              style:ZZBarButtonStyleOrange
                                                             target:self
                                                             action:@selector(reservePark:)];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:reserveButton]];
    [reserveButton release];
  }
}

- (void)switchToOutdoorNavBar:(NSString *)title
        hasSwitchIndoorButton:(BOOL)hasSwitchIndoorButton
{
  [self.navigationItem setTitle:title];
  
  if (hasSwitchIndoorButton) {
    /* leftBarButton:室内 */
    ZZBarButton *switchButton = [[ZZBarButton alloc] initWithTitle:@"室内"
                                                             style:ZZBarButtonStyleGray
                                                            target:self
                                                            action:@selector(switchMap:)];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:switchButton]];
    [switchButton release];
  }
}

- (void)popNavItem
{
  [self.indoorMap destroyBubble];
  [self.tabBar setHidden:NO];
  [self.buttonFindMyCar setHidden:NO];
  [self.buttonParkMyCar setHidden:NO];
  
  receiveCityPointDelegate = nil;
  receiveCityPointSelector = nil;
  
  self.selectedCityPoint      = nil;
  self.selectedCityPointTitle = nil;
}

- (void)pushNavItemToSelectPoint:(NSString *)title
                      backTarget:(id)target
                      backAction:(SEL)action
                   pointReceiver:(SEL)receiver
{
  [self.navigationItem setTitle:title];
  
  ZZBarButton *backButton = [[ZZBarButton alloc] initWithTitle:@"返回"
                                                           style:ZZBarButtonStyleGray
                                                          target:self
                                                          action:@selector(action:)];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
  [backButton release];
  
  [self.tabBar setHidden:YES];
  [self.buttonFindMyCar setHidden:YES];
  [self.buttonParkMyCar setHidden:YES];
  
  receiveCityPointDelegate = target;
  receiveCityPointSelector = receiver;
  
  [self.indoorMap destroyBubble];
}

- (void)overlieFloorsTable:(NSUInteger)floors
{
  if (floors <= 1) {
    return;
  }
  //楼层切换Table
  self.floorsTable = [[[UITableView alloc] initWithFrame:CGRectMake(273, 100, 40, 200)] autorelease];
  self.floorsTable.delegate = self;
  self.floorsTable.dataSource = self;
  self.floorsTable.showsVerticalScrollIndicator = NO;
  [[self.floorsTable layer] setBorderWidth:1.0f];
  self.floorsTable.rowHeight = 40.0f;
  self.floorsTable.alpha = 0.4f;
  [self.view addSubview:self.floorsTable];
}

- (void)removeFloorsTable
{
  [self.floorsTable removeFromSuperview];
  self.floorsTable = nil;
}

- (void)overlieIndoorMap
{
  [self.view insertSubview:self.indoorMap atIndex:1];
  [self overlieFloorsTable:[self.indoorMap currentBuilding].floors.count];
  [self overlieTabloidView];
}

- (void)removeIndoorMap
{
  [self removeFloorsTable];
  [self removeTabloidView];
  [self.indoorMap removeFromSuperview];
}

- (void)overlieTabloidView
{
  if (self.tabloidView) {
    self.tabloidView.frame = CGRectMake(0, 44, 320, 40);
    [self.view addSubview:self.tabloidView];
    [self.buttonParkMyCar setHidden:YES];
    [self.buttonFindMyCar setHidden:YES];
  }
}

- (void)removeTabloidView
{
  [self.tabloidView removeFromSuperview];
//  self.tabloidView = nil;
  [self.buttonParkMyCar setHidden:NO];
  [self.buttonFindMyCar setHidden:NO];
}

#pragma mark - 接口
- (void)showRouteFromCityPoint:(WFCityPoint*)fromCityPoint toCityPoint:(WFCityPoint*)toCityPoint
{
  [self.tabloidView removeFromSuperview];
  NSArray* route = [self.indoorMap routeFromCityPoint:fromCityPoint toCityPoint:toCityPoint showRoute:YES];
  self.tabloidView = [[[WFTabloidView alloc] initWithWiseFlags:route] autorelease];
  [self overlieTabloidView];
}
@end
