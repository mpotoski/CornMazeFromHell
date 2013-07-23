//
//  DRSGridTeleport.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSGridTeleport.h"

@implementation DRSGridTeleport

- (id)init
{
    SKTexture *teleportTexture = [SKTexture textureWithImageNamed:@"teleport.png"];
    self = [super initWithTexture:teleportTexture];
    if (self) {
        [self setSolid:YES];
    }
    return self;
}

@end
