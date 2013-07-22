//
//  DRSGridPlayer.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSGridPlayer.h"

@implementation DRSGridPlayer

- (id)init
{
    SKTexture *playerTexture = [SKTexture textureWithImageNamed:@"player.png"];
    self = [super initWithTexture:playerTexture];
    if (self) {
        [self setSolid:YES];
    }
    return self;
}

@end
