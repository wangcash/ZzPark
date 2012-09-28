//
//  ZZParkTableController.m
//  ZzPark
//
//  Created by 汪 威 on 12-9-24.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "ZZParkTableController.h"
#import "ZZBarButton.h"
#import "WFMapClip.h"
#import "JSONKit.h"

@interface ZZParkTableController ()

@end

@implementation ZZParkTableController
{
  
}

@synthesize arrayParks;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      NSString* indoorMapFilePath = [[WFMapClipDirectory() stringByAppendingPathComponent:@"beijing"] stringByAppendingPathExtension:@"json"];
      
      if ([[NSFileManager defaultManager] fileExistsAtPath:indoorMapFilePath]) {
        NSData* jsonData = [NSData dataWithContentsOfFile:indoorMapFilePath];
        NSDictionary* indoorMapDict = [jsonData objectFromJSONData];
        
        self.arrayParks = [indoorMapDict objectForKey:@"buildings"];
      }
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setNavigationBar];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"附近停车场";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return self.arrayParks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"ParkCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  NSDictionary* building = [self.arrayParks objectAtIndex:indexPath.row];
  cell.textLabel.text = [building objectForKey:@"name"];
  
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
  
  
  
//  for (NSDictionary* building in buildings) {
//    //获得坐标
//    CLLocationCoordinate2D coor;
//    coor.latitude = [[building objectForKey:@"geoPointx"] floatValue];
//    coor.longitude = [[building objectForKey:@"geoPointy"] floatValue];
//    
//    BMKParkAnnotation* annotation = [[BMKParkAnnotation alloc] init];
//    annotation.coordinate = coor;
//    annotation.buildingID = [building objectForKey:@"id"];
//    annotation.buildingName = [building objectForKey:@"name"];
//    annotation.title = annotation.buildingName;
//    
//    NSArray* floors = [building objectForKey:@"floors"];
//    for (NSDictionary* floorDict in floors) {
//      if ([floorDict objectForKey:@"clipId"]) {
//        annotation.defaultMapClipID = [floorDict objectForKey:@"clipId"];
//      }
//      else {
//        annotation.defaultMapClipID = nil;
//      }
//      break;
//    }
//    
//    [self.outdoorMap addAnnotation:annotation];
//    [annotation release];
//  }
}

- (void)setNavigationBar
{
  [self.navigationItem setTitle:@"停车场"];
  
  /* leftBarButton*/
  ZZBarButton *closeButton = [[ZZBarButton alloc] initWithTitle:@"返回"
                                                          style:ZZBarButtonStyleGray
                                                         target:self
                                                         action:@selector(close:)];
  [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:closeButton]];
  [closeButton release];
}

- (IBAction)close:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
  NSLog(@"fjfjfjfjfjfjfjfjfjfj");
}

@end
