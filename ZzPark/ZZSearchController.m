//
//  ZZSearchController.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-17.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZSearchController.h"
#import "ZZBarButton.h"

@implementation ZZSearchController
{
  NSMutableArray* _arrResult;
}

@synthesize mainController;
@synthesize searchKeywords, pageControl, scrollView, searchResultView, searchButtonView;

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
  
  [self setNavigationBar];
  
  [self resetSearch];
  
  self.scrollView.contentSize = CGSizeMake(320 * 2, 372);
  
  self.searchResultView.frame = CGRectMake(0, 0, 320, 372);
  [self.scrollView addSubview:self.searchResultView];
  
  self.searchButtonView.frame = CGRectMake(320, 0, 320, 372);
  [self.scrollView addSubview:self.searchButtonView];
}


- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)setNavigationBar
{
  [self.navigationItem setTitle:@"搜索"];
  
  /* leftBarButton:取消 */
  ZZBarButton *closeButton = [[ZZBarButton alloc] initWithTitle:@"取消"
                                                          style:ZZBarButtonStyleGray
                                                         target:self
                                                         action:@selector(close:)];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:closeButton]];
  [closeButton release];
}

- (IBAction)close:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (void)resetSearch
{
  WFRoomManager* roomManager = [WFRoomManager sharedInstance];
  
  //重置搜索
  [_arrResult release];
  _arrResult = [[NSMutableArray arrayWithArray:[roomManager allBusinessRooms]] retain];
  [_arrResult sortUsingSelector:@selector(compareMethodWithRoomName:)];
}

#pragma mark UITableViewDataSource and UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section 
{
  return _arrResult.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  [self.searchKeywords resignFirstResponder];
  
  static NSString* reuseIdetify = @"RoomsTableViewCell";
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
  if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify] autorelease];
  }
  
  WFRoom* room = [_arrResult objectAtIndex:indexPath.row];
  cell.textLabel.text = room.roomName;
  
  return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
  WFRoom* room = [_arrResult objectAtIndex:indexPath.row];
  
  [self close:nil];
  
  NSLog(@"%@", room.centralCityPoint.mapClipID);
  [self.mainController.indoorMap setMapClip:room.centralCityPoint.mapClip];
}
 
#pragma mark UISearchBarDelegate Methods 
//当输入框内容改变时
- (void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
  [self resetSearch];
  
  //有文字输入时候
  if (searchText.length > 0) {
    NSMutableArray* toRemove=[NSMutableArray array];
    for (WFRoom* room in _arrResult) {
      if ([room.roomName rangeOfString:searchText options:NSCaseInsensitiveSearch].location == NSNotFound) {
        [toRemove addObject:room];
      }
    }
    [_arrResult removeObjectsInArray:toRemove];
  }
  
  [self.searchResultView reloadData];
} 

//当开始编辑时
- (void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar 
{
  NSLog(@"%s", __FUNCTION__); 
} 

//当编辑结束时
- (void)searchBarTextDidEndEditing:(UISearchBar*)searchBar
{
  NSLog(@"%s", __FUNCTION__);
} 

//当按键开始搜索时
- (void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
  NSLog(@"%s", __FUNCTION__);
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
  NSLog(@"%s", __FUNCTION__);
  [self.searchKeywords resignFirstResponder];
}  

- (void)searchBar:(UISearchBar*)searchBar activate:(BOOL)active
{
  NSLog(@"%s", __FUNCTION__);
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  self.pageControl.currentPage = self.scrollView.contentOffset.x / 320;
}

@end
