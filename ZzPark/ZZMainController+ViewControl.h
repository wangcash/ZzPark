//
//  ZZMainController+ViewControl.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZMainController.h"

@interface ZZMainController (ViewControl)

- (void)switchToIndoorNavBar:(NSString *)title
            hasReserveButton:(BOOL)hasReserveButton;
- (void)switchToOutdoorNavBar:(NSString *)title
        hasSwitchIndoorButton:(BOOL)hasSwitchIndoorButton;

- (void)popNavItem;
- (void)pushNavItemToSelectPoint:(NSString *)title
                      backTarget:(id)target
                      backAction:(SEL)action
                   pointReceiver:(SEL)receiver;

- (void)overlieFloorsTable:(NSUInteger)floors;
- (void)removeFloorsTable;

- (void)overlieIndoorMap;
- (void)removeIndoorMap;

- (void)showRouteFromCityPoint:(WFCityPoint*)fromCityPoint
                   toCityPoint:(WFCityPoint*)toCityPoint;


@end
