//
//  DRSMyScene.m
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import "DRSMyScene.h"
#import "DRSMazeGrid.h"
#import "DRSGridObject.h"


@implementation DRSMyScene {
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.3 blue:0.15 alpha:1.0];
        [self setMazeGrid:[[DRSMazeGrid alloc] initWithLevel:@1]];
        
        [self calculateAndSetMazeGridBoundsAndSquareHeight];

        [self populateWithObjects];
    }
    return self;
}

- (void)populateWithObjects {
    if (![self mazeGrid]) { return; }
    for (DRSPosition *p in [[self mazeGrid] gridObjects]) {
        DRSGridObject *gridObject = [[[self mazeGrid] gridObjects] objectForKey:p];
        [gridObject setAnchorPoint:CGPointMake(0, 0)];
//        [gridObject texture].size = CGSizeMake([self squareHeight], [self squareHeight])
        gridObject.position = CGPointMake(p.col * [self squareHeight] - self.mazeGridBounds.size.width/2, p.row * [self squareHeight] - self.mazeGridBounds.size.height/2);
        [[self mazeGridBounds] addChild:gridObject];
    }
}

-(void)calculateAndSetMazeGridBoundsAndSquareHeight {
    NSNumber *rows = [[self mazeGrid] rows];
    NSNumber *cols = [[self mazeGrid] cols];
    
    
    CGFloat mazeAspectRatio = [cols floatValue] / [rows floatValue];
    CGFloat selfAspectRatio = self.frame.size.height / self.frame.size.width;
    
    if (mazeAspectRatio <= selfAspectRatio) {
        [self setSquareHeight:self.frame.size.width / [cols floatValue]];
    } else {
        [self setSquareHeight:self.frame.size.height / [rows floatValue]];
    }
    
    CGFloat boundsWidth = [cols floatValue]*[self squareHeight];
    CGFloat boundsHeight = [rows floatValue]*[self squareHeight];
    
    CGSize boundsSize = CGSizeMake(boundsWidth,boundsHeight);
    [self setMazeGridBounds:[[SKSpriteNode alloc] initWithColor:[SKColor clearColor] size:boundsSize]];
    
    [[self mazeGridBounds] setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) ];//CGPointMake((self.frame.size.width - boundsHeight)/2, (self.frame.size.height - boundsWidth)/2)];
    [self addChild:[self mazeGridBounds]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
