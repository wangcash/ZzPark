//
//  ZZMainController.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-2.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFMapKit.h"
#import "ZZTabBar.h"

#import "BMKParkAnnotation.h"
#import "BMKParkAnnotationView.h"

@interface ZZMainController : UIViewController<WFMapViewDelegate,WFLocationManagerDelegate,BMKMapViewDelegate,ZZTabBarDelegate,WFIndoorMapUpdatedDelegate,UITableViewDelegate,UITableViewDataSource>
{
  //导航条是否跟随室内位置更新而更新
  BOOL isNavBarRefresh;
  
  //用户地图点选
  id  receiveCityPointDelegate;
  SEL receiveCityPointSelector;
  IBOutlet UIView*    selectCityPointView;
  IBOutlet UILabel*   selectCityPointLabel;
  IBOutlet UIButton*  selectCityPointButton;
}

//@property (nonatomic, retain) IBOutlet UINavigationBar* navBar;
@property (nonatomic, retain)          ZZTabBar*        tabBar;

@property (nonatomic, retain) UIButton* buttonParkMyCar;
@property (nonatomic, retain) UIButton* buttonFindMyCar;

@property (nonatomic, retain) BMKMapView*    outdoorMap;
@property (nonatomic, retain) WFMapView*     indoorMap;
@property (nonatomic, retain) UITableView*   floorsTable;
@property (nonatomic, retain) WFTabloidView* tabloidView;

@property (nonatomic, retain) WFCityPoint* selectedCityPoint;
@property (nonatomic, retain) NSString*    selectedCityPointTitle;

@end
