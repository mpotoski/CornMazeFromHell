//
//  DRSMazeGrid.h
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRSPosition;

@interface DRSMazeGrid : NSObject

@property (nonatomic, strong) NSMutableDictionary *gridObjects;
@property (nonatomic, strong) DRSPosition *playerPosition;
@property (nonatomic) NSNumber *rows;
@property (nonatomic) NSNumber *cols;

- (id) initWithLevel:(NSNumber *)levelNumber;

@end
