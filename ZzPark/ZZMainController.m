//
//  ZZMainController.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-2.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZMainController.h"
#import "ZZMainController+ViewControl.h"
#import "ZZSearchController.h"
#import "ZZNavigationController.h"
#import "ZZServiceController.h"
#import "ZZParkTableController.h"
#import "ZZMoreTableController.h"

@implementation ZZMainController
{
  BMKMapView*   _outdoorMap;
  WFMapView*    _indoorMap;
  
  WFCityPoint*  _tapCityPoint;
}

//@synthesize navBar;
@synthesize tabBar;
@synthesize outdoorMap, indoorMap, floorsTable, tabloidView;
@synthesize buttonParkMyCar, buttonFindMyCar;
@synthesize selectedCityPoint, selectedCityPointTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  }
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //创建户外、室内地图View
  BMKMapView *outdoor = [[BMKMapView alloc] initWithFrame:self.view.bounds];
  outdoor.delegate = self;
  self.outdoorMap = outdoor;
  [outdoor release];
  
  WFMapView *indoor = [[WFMapView alloc] initWithFrame:self.view.bounds];
  indoor.mapViewDelegate = self;
  self.indoorMap = indoor;
  [indoor release];
  
  //显示室外地图
  [self.view insertSubview:self.outdoorMap atIndex:0];
  isNavBarRefresh = YES;
  
  //更新导航栏
  [self switchToOutdoorNavBar:@"转转停车" hasSwitchIndoorButton:NO];
  
  //停车找车按钮
  UIImage* buttonImage = nil;
  UIImage* buttonImageHighlight = nil;
  
  buttonImage = [UIImage imageNamed:@"ParkMyCar"];
  buttonImageHighlight = [UIImage imageNamed:@"ParkMyCar_Highlight"];
  UIButton* bPark = [[UIButton alloc] initWithFrame:CGRectMake(268, 50, buttonImage.size.width, buttonImage.size.height)];
  [bPark setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [bPark setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
  [bPark addTarget:self action:@selector(parkMyCar:) forControlEvents:UIControlEventTouchUpInside];
  self.buttonParkMyCar = bPark;
  [self.view addSubview:self.buttonParkMyCar];
  [bPark release];
  
  buttonImage = [UIImage imageNamed:@"FindMyCar"];
  buttonImageHighlight = [UIImage imageNamed:@"FindMyCar_Highlight"];
  UIButton* bFind = [[UIButton alloc] initWithFrame:CGRectMake(216, 50, buttonImage.size.width, buttonImage.size.height)];
  [bFind setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [bFind setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
  [bFind addTarget:self action:@selector(findMyCar:) forControlEvents:UIControlEventTouchUpInside];
  self.buttonFindMyCar = bFind;
  [self.view addSubview:self.buttonFindMyCar];
  [bFind release];
  
  //显示工具栏
  self.tabBar = [[[ZZTabBar alloc] init] autorelease];
  [self.view addSubview:self.tabBar];

  //启动户外定位
  [self.outdoorMap setShowsUserLocation:YES];
  
  //TODO启动室内定位
  WFLocationManager *locationManager = [WFLocationManager sharedInstance];
  locationManager.delegate = self;
  locationManager.distanceFilter = 10;
  [locationManager startUpdatingLocation];
  
  //显示室内位置
  [self.indoorMap showCurrentLocation];
  
  //从服务器获得当前城市中支持室内地图的清单
  WFServiceManager *serviceManager = [WFServiceManager sharedInstance];
  [serviceManager downloadIndoorMapWithCity:@"beijing" updatedDelegate:self];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  self.outdoorMap = nil;
  self.indoorMap = nil;
  self.tabBar = nil;
  self.buttonParkMyCar = nil;
  self.buttonFindMyCar = nil;
}

- (void)switchMap:(id)sender
{
  if (self.indoorMap.superview == nil) {
    //添加室内地图图层
    [self overlieIndoorMap];
    
    WFLocationManager *locationManager = [WFLocationManager sharedInstance];
    [self.indoorMap setMapClip:locationManager.currentCityPoint.mapClip];
    
    [self switchToIndoorNavBar:@"转转停车" hasReserveButton:NO];
  }
  else {
    //移除室内地图图层
    [self removeIndoorMap];
    
    [self switchToOutdoorNavBar:@"转转停车" hasSwitchIndoorButton:YES];
    isNavBarRefresh = YES;
  }
}

- (void)touchTabBarButton:(id)sender
{
  UIButton *button = sender;
  
  switch (button.tag) {
    case 1: { //搜索

      if (self.indoorMap.superview == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前版本暂不支持室外地图搜索"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
      }
      else {
        ZZSearchController* searchController = [[[ZZSearchController alloc] init] autorelease];
        searchController.mainController = self;
        [self.navigationController pushViewController:searchController animated:YES];
      }
      break;
    }
    case 2: { //导航
      if (self.indoorMap.superview == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前版本暂不支持室外地图导航"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
      }
      else {
        ZZNavigationController *navController = [[[ZZNavigationController alloc] init] autorelease];
        navController.mainController = self;
        [self.navigationController pushViewController:navController animated:YES];
        
//        navigation.mainController = self;
//        self.navController = navigation;
//        [self.view addSubview:self.navController.view];
//        [navigation release];
      }
      break;
    }
    case 3: { //停车场
      ZZParkTableController* parkTableController = [[[ZZParkTableController alloc] initWithStyle:UITableViewStylePlain] autorelease];
      [self.navigationController pushViewController:parkTableController animated:YES];
      break;
    }
    case 4: { //更多
      ZZMoreTableController* moreTalbeController = [[[ZZMoreTableController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
      [self.navigationController pushViewController:moreTalbeController animated:YES];
      break;
    }
    case 0: { //定位
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该功能还未开发完..."
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"去试用其它功能"
                                            otherButtonTitles:nil];
      [alert show];
      [alert release];
      break;
    }


  }
}

- (void)reservePark:(id)sender
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预订车位正在开发中..."
                                                  message:nil
                                                 delegate:nil
                                        cancelButtonTitle:@"去试用其它功能"
                                        otherButtonTitles:nil];
  [alert show];
  [alert release];
}


#pragma mark - ======户外地图相关方法======

#pragma mark 用户位置更新
// Override
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
//    NSString *message = [NSString stringWithFormat:@"精度:%f\n纬度:%f", userLocation.location.coordinate.longitude, userLocation.location.coordinate.latitude, nil];
//    [[[[UIAlertView alloc] initWithTitle:@"位置..."
//                                 message:message
//                                delegate:nil
//                       cancelButtonTitle:@"确定"
//                       otherButtonTitles:nil] autorelease] show];
//    NSLog(@"%@", message);
	}
}

// Override
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
		NSLog(@"locate failed: %@", [error localizedDescription]);
	else {
		NSLog(@"locate failed");
	}
}

// Override
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

// Override
- (BMKAnnotationView*)mapView:(BMKMapView*)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKParkAnnotation class]]) {
    static NSString *ID = @"parkAnnotation";
    BMKParkAnnotationView* parkAnnotationView =(BMKParkAnnotationView*)[self.outdoorMap dequeueReusableAnnotationViewWithIdentifier:ID];
    if (parkAnnotationView == nil) {
      parkAnnotationView = [[BMKParkAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    parkAnnotationView.delegate = self;
    parkAnnotationView.intoBuildingSelector = @selector(intoBuildingWithDefaultFloorID:);
    
		return [parkAnnotationView autorelease];
	}
	return nil;
}





#pragma mark - ======室内地图相关方法======

#pragma mark 用户位置更新
- (void)locationManager:(WFLocationManager *)manager didUpdateCityPoint:(WFCityPoint *)newCityPoint
{
  NSLog(@"[%@]%@", newCityPoint.mapClipID, NSStringFromCGPoint(newCityPoint.CGPoint));
//  [self.indoorMap setMapClip:newCityPoint.mapClip];
  
  //更新导航栏
  if (isNavBarRefresh) {
    [self switchToOutdoorNavBar:@"转转停车" hasSwitchIndoorButton:YES];
    isNavBarRefresh = NO;
    NSLog(@"NavBar Refresh");
  }
}

#pragma mark 点击拾取
- (void)singleTapPoint:(CGPoint)point currentScale:(CGFloat)scale tapObjectArray:(NSArray*)array
{
  NSLog(@"==== ====[%s]==== ====",__FUNCTION__);
  
  NSLog(@"point: %@", NSStringFromCGPoint(point));
  
  if (receiveCityPointDelegate && receiveCityPointSelector) {
    if(array.count >= 1) {
      id object = [array objectAtIndex:0];

      if ([object isKindOfClass:[WFWiseFlagAnnotation class]]) {
        WFWiseFlagAnnotation* annotation = object;
        self.selectedCityPoint = [self.indoorMap cityPointWithCGPoint:annotation.point];
        self.selectedCityPointTitle = annotation.shortName;
        selectCityPointLabel.text = self.selectedCityPointTitle;
      }
      else if ([object isKindOfClass:[WFImageAnnotation class]]) {
        WFImageAnnotation* annotation = object;
        self.selectedCityPoint = [self.indoorMap cityPointWithCGPoint:annotation.point];
        self.selectedCityPointTitle = annotation.title;
        selectCityPointLabel.text = self.selectedCityPointTitle;
      }
      else {
        self.selectedCityPoint = [self.indoorMap cityPointWithCGPoint:point];
        self.selectedCityPointTitle = @"选中位置";
        selectCityPointLabel.text = @"选中";
      }
      
      [self.indoorMap popupBubbleAtPoint:self.selectedCityPoint.CGPoint
                             contentView:selectCityPointView
                             contentSize:selectCityPointView.frame.size];
    }
    return;
  }
  
  if (self.tabloidView.superview) {
    WFWiseFlagBox* box = [WFWiseFlagBox sharedInstance];
    WFWiseFlag* wiseflag = [box nearWiseFlagWithCityPoint:[self.indoorMap cityPointWithCGPoint:point]];
    [self.tabloidView setCurrentWiseFlag:wiseflag];
    return;
  }
  
  //拾取
  for (NSInteger i=0; i<array.count; i++) {
    id object = [array objectAtIndex:i];
    if ([object isKindOfClass:[WFWiseFlagAnnotation class]]) {
      WFWiseFlagAnnotation* annotation = object;
      [self.indoorMap popupBubbleAtPoint:annotation.point contentString:annotation.shortName];
      return;
    }
    if ([object isKindOfClass:[WFImageAnnotation class]]) {
      WFImageAnnotation* annotation = object;
      [self.indoorMap popupBubbleAtPoint:annotation.point contentString:annotation.title];
      return;
    }
  }
  
  _tapCityPoint = [[self.indoorMap cityPointWithCGPoint:point] retain];
}

#pragma mark - ======业务处理方法======
- (IBAction)parkMyCar:(id)sender
{
  [[[[UIAlertView alloc] initWithTitle:@"停车"
                               message:@"功能正在开发中..."
                              delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil] autorelease] show];
}

- (IBAction)findMyCar:(id)sender
{
  [[[[UIAlertView alloc] initWithTitle:@"找车"
                               message:@"功能正在开发中..."
                              delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil] autorelease] show];
}

- (IBAction)selectedCityPoint:(id)sender
{
  [receiveCityPointDelegate performSelector:receiveCityPointSelector withObject:self.selectedCityPoint withObject:self.selectedCityPointTitle];
}

- (void)indoorMapUpdated:(NSArray*)buildings
{
  if (buildings == nil) {
    return;
  }
  
  for (NSDictionary* building in buildings) {
    //获得坐标
    CLLocationCoordinate2D coor;
    coor.latitude = [[building objectForKey:@"geoPointx"] floatValue];
    coor.longitude = [[building objectForKey:@"geoPointy"] floatValue];

    BMKParkAnnotation* annotation = [[BMKParkAnnotation alloc] init];
    annotation.coordinate = coor;
    annotation.buildingID = [building objectForKey:@"id"];
    annotation.buildingName = [building objectForKey:@"name"];
    annotation.title = annotation.buildingName;
    
    NSArray* floors = [building objectForKey:@"floors"];
    for (NSDictionary* floorDict in floors) {
      if ([floorDict objectForKey:@"clipId"]) {
        annotation.defaultMapClipID = [floorDict objectForKey:@"clipId"];
      }
      else {
        annotation.defaultMapClipID = nil;
      }
      break;
    }

    [self.outdoorMap addAnnotation:annotation];
    [annotation release];
  }
}

- (void)intoBuildingWithDefaultFloorID:(NSString*)mapClipID
{
  //添加室内地图图层
  [self.indoorMap setMapClipID:mapClipID];
  [self overlieIndoorMap];
  [self.indoorMap downloadBuilding];
  
  [self switchToIndoorNavBar:@"转转停车" hasReserveButton:YES];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
  return [self.indoorMap currentBuilding].floors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* reuseIdetify = @"FloorTableViewCell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
  if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
  }
  
  //获得楼层列表
  NSArray* floors = [self.indoorMap currentBuilding].floors;
  //由高到低方式显示楼层名
  WFFloor* floor = [floors objectAtIndex:(floors.count - indexPath.row - 1)];
  
  cell.textLabel.text = floor.name;
  
  cell.textLabel.textAlignment = UITextAlignmentCenter;
  cell.textLabel.font = [cell.textLabel.font fontWithSize:15.0f];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  CGRect rect = tableView.frame;
  //  rect.size.height -= 100;
  //  tableView.frame = rect;
  
  NSLog(@"indexPath.row=%d", indexPath.row);
  
  //获得楼层列表
  NSArray* floors = [self.indoorMap currentBuilding].floors;
  //由高到低方式显示楼层名
  WFFloor* floor = [floors objectAtIndex:(floors.count - indexPath.row - 1)];
  
  NSLog(@"MapClipID = %@", floor.mapClipID);
  
  [self.indoorMap setMapClipID:floor.mapClipID];
}




@end
