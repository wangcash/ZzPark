//
//  BMKParkAnnotationView.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-29.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

//#import "BMKAnnotationView.h"
#import "BMKPinAnnotationView.h"
#import "BMKParkAnnotation.h"

@interface BMKParkAnnotationView : BMKPinAnnotationView

@property (nonatomic, retain) id delegate;
@property (nonatomic) SEL intoBuildingSelector;

@end
