//
//  BMKParkAnnotation.h
//  ZzPark
//
//  Created by 汪 威 on 12-8-29.
//  Copyright (c) 2012年 365path.com. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface BMKParkAnnotation : BMKPointAnnotation

@property (nonatomic, retain) NSString* buildingID;
@property (nonatomic, retain) NSString* buildingName;
@property (nonatomic, retain) NSString* defaultMapClipID;

@end
