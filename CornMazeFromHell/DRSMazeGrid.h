//
//  DRSMazeGrid.h
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRSPosition;
@class DRSGridPlayer;

@interface DRSMazeGrid : NSObject

@property (nonatomic, strong) NSMutableDictionary *gridObjects;
@property (nonatomic, strong) DRSPosition *playerPosition;
@property (nonatomic) NSNumber *rows;
@property (nonatomic) NSNumber *cols;

@property (nonatomic, strong) DRSGridPlayer *player;

- (id) initWithLevel:(NSNumber *)levelNumber;

- (BOOL)isValidPosition:(DRSPosition *)p;

@end
