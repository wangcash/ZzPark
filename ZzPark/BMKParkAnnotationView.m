//
//  BMKParkAnnotationView.m
//  ZzPark
//
//  Created by 汪 威 on 12-8-29.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "BMKParkAnnotationView.h"

@implementation BMKParkAnnotationView

@synthesize delegate, intoBuildingSelector;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
  if (self) {
    self.image = [UIImage imageNamed:@"pin_park.png"];
    
    self.canShowCallout = YES;
    self.draggable = NO;
    self.animatesDrop = YES;
    
    BMKParkAnnotation* parkAnnotation = (BMKParkAnnotation*)annotation;
    if (parkAnnotation) {
      UIButton* intoBuildingButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
      [intoBuildingButton addTarget:self action:@selector(intoBuilding:) forControlEvents:UIControlEventTouchUpInside];
      
      self.rightCalloutAccessoryView = intoBuildingButton;
    }
  }
  return self;
}

- (IBAction)intoBuilding:(id)sender
{
  BMKParkAnnotation* annotation = (BMKParkAnnotation*)self.annotation;
  if ([self.delegate respondsToSelector:intoBuildingSelector]) {
    [self.delegate performSelector:intoBuildingSelector withObject:annotation.defaultMapClipID];
  }
}


@end
