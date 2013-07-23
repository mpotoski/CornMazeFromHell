//
//  DRSFileReader.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSFileReader.h"

@interface DRSFileReader (){
    NSMutableDictionary *_loadedLevels;
}

-(NSArray *)dimensionsForLevel:(NSNumber *)levelNumber;
-(NSArray *)linesForLevel:(NSNumber *)levelNumber;

@end

@implementation DRSFileReader

- (id)init
{
    self = [super init];
    if (self) {
        _loadedLevels = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSArray *)mazeStringsRepresentationForLevel:(NSNumber *)levelNumber {
    NSArray *lines = [self linesForLevel:levelNumber];
    NSRange range = NSMakeRange(1, [[self rowsForLevel:levelNumber] integerValue]);
    return [lines subarrayWithRange: range];
}

- (NSArray *)linesForLevel:(NSNumber *)levelNumber {
    if(![_loadedLevels objectForKey:levelNumber]) {
        NSString *filename = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"lvl%@", levelNumber] ofType:@"txt"];
        NSError *error = nil;
        NSString * fileContents = [NSString stringWithContentsOfFile:filename encoding:NSASCIIStringEncoding error:&error];
        if (!error) {
            NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            [_loadedLevels setObject:lines forKey:levelNumber];
        } else {
            NSLog(@"Error reading file: %@", [error localizedDescription]);
        }
    }
    return [_loadedLevels objectForKey:levelNumber];
}


#pragma mark Dimensions

- (NSNumber *)rowsForLevel:(NSNumber *)levelNumber {
    NSArray *dimensions = [self dimensionsForLevel:levelNumber];
    return [NSNumber numberWithInteger:[(NSString *)[dimensions objectAtIndex:0] integerValue]];
}

- (NSNumber *)columnsForLevel:(NSNumber *)levelNumber {
    NSArray *dimensions = [self dimensionsForLevel:levelNumber];
    return [NSNumber numberWithInteger:[(NSString *)[dimensions objectAtIndex:1] integerValue]];
}

- (NSArray *)dimensionsForLevel:(NSNumber *)levelNumber {
    NSArray *lines = [self linesForLevel:levelNumber];
    NSString *firstLine = [lines firstObject];
    return [firstLine componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


@end
