//
//  DRSPosition.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSPosition.h"

@implementation DRSPosition

- (id)initWithRow:(int)row andCol:(int) col;
{
    self = [super init];
    if (self) {
        _row = row;
        _col = col;
    }
    return self;
}

- (id)init {
    return [self initWithRow:0 andCol:0];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setRow:[self row]];
        [copy setCol:[self col]];
    }
    return copy;
}

@end
