//
//  ZZSearchController.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-17.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFMapKit.h"
#import "ZZMainController.h"
#import "ZZMainController+ViewControl.h"

@interface ZZSearchController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>

@property (nonatomic, retain) ZZMainController* mainController;

@property (nonatomic, retain) IBOutlet UISearchBar*   searchKeywords;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView*  scrollView;

@property (nonatomic, retain) IBOutlet UITableView*   searchResultView;
@property (nonatomic, retain) IBOutlet UIView*        searchButtonView;

- (IBAction)close:(id)sender;

@end
