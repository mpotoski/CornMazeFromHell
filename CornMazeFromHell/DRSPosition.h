//
//  DRSPosition.h
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRSPosition : NSObject<NSCopying>

@property (nonatomic) int row;
@property (nonatomic) int col;

- initWithRow:(int)row andCol:(int)col;

@end
