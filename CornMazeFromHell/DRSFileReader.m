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

-(NSArray *)mazeStringsRepresentationForLevel:(NSNumber *)levelNumber {
    NSArray *lines = [self linesForLevel:levelNumber];
    return [lines subarrayWithRange:NSMakeRange(1, (NSUInteger)[self rowsForLevel:levelNumber])];
}

- (NSArray *)linesForLevel:(NSNumber *)levelNumber {
    if(![_loadedLevels objectForKey:levelNumber]) {
        NSString *filename = [NSString stringWithFormat:@"lvl%@.txt", levelNumber];
        NSString * fileContents = [NSString stringWithContentsOfFile:filename encoding:NSASCIIStringEncoding error:nil];
        NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        [_loadedLevels setObject:lines forKey:levelNumber];
    }
    return [_loadedLevels objectForKey:levelNumber];
}


#pragma mark Dimensions

- (NSNumber *)rowsForLevel:(NSNumber *)levelNumber {
    NSArray *dimensions = [self dimensionsForLevel:levelNumber];
    return [NSNumber numberWithInt:[[dimensions objectAtIndex:0] integerValue]];
}

- (NSNumber *)columnsForLevel:(NSNumber *)levelNumber {
    NSArray *dimensions = [self dimensionsForLevel:levelNumber];
    return [NSNumber numberWithInt:[[dimensions objectAtIndex:1] integerValue]];
}

- (NSArray *)dimensionsForLevel:(NSNumber *)levelNumber {
    NSArray *lines = [self linesForLevel:levelNumber];
    NSString *firstLine = [lines firstObject];
    return [firstLine componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


@end
