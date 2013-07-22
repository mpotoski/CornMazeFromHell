//
//  DRSGridGoal.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSGridGoal.h"

@implementation DRSGridGoal

- (id)init
{
    self = [super init];
    if (self) {
        //Generate a black/white grid 4x4
        [self setColor:[SKColor whiteColor]];
        CGFloat height = self.frame.size.height/4.0;
        CGFloat width = self.frame.size.width/4.0;
        for (int i=0; i<4; i++) {
            for (int j=0; j<4; j++) {
                if((i+j) % 2 == 0) {
                    SKSpriteNode *blacksquare = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(width, height)];
                    [blacksquare setPosition:CGPointMake(i*width, j*height)];
                    [self addChild:blacksquare];
                }
            }
        }
        
        [self setSolid:NO];
    }
    
    return self;
}

@end
