//
//  DRSMazeGrid.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSMazeGrid.h"
#import "DRSFileReader.h"
#import "DRSGridGoal.h"
#import "DRSGridPlayer.h"
#import "DRSGridTeleport.h"
#import "DRSGridTree.h"
#import "DRSPosition.h"

typedef NS_ENUM(char, GridObjectSymbolType) {
    GridObjectSymbolTypeTree = '#',
    GridObjectSymbolTypeStartLocation = '*',
    GridObjectSymbolTypeGoal = 'X'
};

@implementation DRSMazeGrid {
    DRSFileReader *_fileReader;
}

- (id)initWithLevel:(NSNumber *)levelNumber
{
    self = [super init];
    if (self) {
        _fileReader = [[DRSFileReader alloc] init];
        _gridObjects = [[NSMutableDictionary alloc] init];
        NSArray *lines = [_fileReader mazeStringsRepresentationForLevel:levelNumber];
        [self setRows:[_fileReader rowsForLevel:levelNumber]];
        [self setCols:[_fileReader columnsForLevel:levelNumber]];
        [self convertStringsToGridObjects:lines];
    }
    return self;
}

- (void)convertStringsToGridObjects:(NSArray *)stringLines{
    NSMutableDictionary *unplacedTeleports = [[NSMutableDictionary alloc] init];
    
    for (int r = 0; r < [stringLines count]; r++) {

        NSString *stringLine = stringLines[r];
        for (int c = 0; c < [stringLine length]; c++) {
           
            DRSPosition *position = [[DRSPosition alloc] initWithRow:r andCol:c];
            
            switch ([stringLine characterAtIndex:c]) {
                case GridObjectSymbolTypeTree: {
                    DRSGridTree *tree = [[DRSGridTree alloc] init];
                    [tree setGridPosition:position];
                    [_gridObjects setObject:tree forKey:position];
                    break;
                }
                case GridObjectSymbolTypeStartLocation: {
                    [self setPlayerPosition:position];
                    break;
                }
                case GridObjectSymbolTypeGoal: {
                    DRSGridGoal *goal = [[DRSGridGoal alloc] init];
                    [goal setGridPosition:position];
                    [_gridObjects setObject:goal forKey:position];
                    break;
                }
                default: {
                    /*Teleports. 'X' will not be in the set.*/
                    if ([[NSCharacterSet letterCharacterSet] characterIsMember:c]) {
                        DRSGridTeleport *teleport = [[DRSGridTeleport alloc] init];
                        [teleport setGridPosition:position];
                        
                        NSString *key = [NSString stringWithFormat:@"%c", c];
                        if ([unplacedTeleports objectForKey:key]) {
                            DRSGridTeleport *buddyTeleport = [unplacedTeleports objectForKey:key];
                            
                            // Set each other as buddies
                            [buddyTeleport setBuddyTeleport:teleport];
                            [teleport setBuddyTeleport:buddyTeleport];
                            
                            // Add both now
                            [_gridObjects setObject:teleport forKey:position];
                            [_gridObjects setObject:buddyTeleport forKey:buddyTeleport.gridPosition];
                            
                            [unplacedTeleports removeObjectForKey:key];
                        } else {
                            // It will be added later
                            [unplacedTeleports setObject:teleport forKey:key];
                        }
                    }
                    break;
                }
            }
        }
    }
}

- (id)init
{
    return [self initWithLevel:@1];
}

@end
