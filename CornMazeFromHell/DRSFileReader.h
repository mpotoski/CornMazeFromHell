//
//  DRSFileReader.h
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRSFileReader : NSObject

- (NSArray *)mazeStringsRepresentationForLevel:(NSNumber *)levelNumber;
- (NSNumber *)rowsForLevel:(NSNumber *)levelNumber;
- (NSNumber *)columnsForLevel:(NSNumber *)levelNumber;

@end
