//
//  ZZServiceController.m
//  ZzPark
//
//  Created by 汪 威 on 12-9-15.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZServiceController.h"
#import "WFServiceManager.h"

//#define MobileNumber @"18679113569"
#define MobileNumber @"13889153605"

@interface ZZServiceController ()

@end

@implementation ZZServiceController
{
  NSMutableArray* _arrService;
  WFServiceManager* _serviceManager;
  
  NSString* _sid;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
    _arrService = [[NSMutableArray alloc] init];
    _serviceManager = [WFServiceManager sharedInstance];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  ;
  
  [_arrService addObject:[NSString stringWithFormat:@"用户注册 %@", MobileNumber]];
  [_arrService addObject:[NSString stringWithFormat:@"用户登录 %@", MobileNumber]];
  [_arrService addObject:[NSString stringWithFormat:@"用户登出 %@", MobileNumber]];
  [_arrService addObject:[NSString stringWithFormat:@"修改密码为1111 %@", MobileNumber]];
  [_arrService addObject:[NSString stringWithFormat:@"重置密码 %@", MobileNumber]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _arrService.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.textLabel.text = [_arrService objectAtIndex:indexPath.row];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
  switch (indexPath.row) {
    case 0:
      [_serviceManager userRegister:MobileNumber];
      break;
    case 1:
      _sid = [[_serviceManager userLogin:MobileNumber password:@"952441"] retain];
      break;
    case 2:
      [_serviceManager userLogout:MobileNumber sessionId:_sid];
      break;
    case 3:
      [_serviceManager userChangePassword:MobileNumber sessionId:_sid password:@"952441" newPassword:@"1111"];
      break;
    case 4:
      [_serviceManager userResetPassword:MobileNumber];
      break;
    default:
      break;
  }
}

@end
