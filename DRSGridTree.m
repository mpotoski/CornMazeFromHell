//
//  DRSGridTree.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSGridTree.h"

@implementation DRSGridTree

- (id)init
{
    SKTexture *treeTexture = [SKTexture textureWithImageNamed:@"tree.png"];
    self = [super initWithTexture:treeTexture];
    if (self) {
        [self setSolid:YES];
    }
    return self;
}

@end
