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
#import "DRSPosition.h"
#import "DRSGridGoal.h"
#import "DRSGridTeleport.h"
#import "DRSGridPlayer.h"

typedef enum Direction {
    Up,
    Down,
    Right,
    Left
} Direction;


@implementation DRSMyScene {
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.3 blue:0.15 alpha:1.0];
        [self setMazeGrid:[[DRSMazeGrid alloc] initWithLevel:@1]];
        
        [self calculateAndSetMazeGridBoundsAndSquareHeight];

        [self populateWithObjects];
        [self drawPlayerObject];
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

- (void)drawPlayerObject {
    DRSGridPlayer *player = self.mazeGrid.player;
    DRSPosition *p = player.gridPosition;
    [player setAnchorPoint:CGPointMake(0, 0)];
    player.position = CGPointMake(p.col * [self squareHeight] - self.mazeGridBounds.size.width/2, p.row * [self squareHeight] - self.mazeGridBounds.size.height/2);
    [[self mazeGridBounds] addChild:player];
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

// -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
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
// }

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


#pragma mark - User interaction

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    Direction d = [self directionFromPoint:location];
    [self movePlayer:d];
}

- (Direction)directionFromPoint:(CGPoint)location {

    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    // downLine: imaginary line from top left to bottom right
    // upLine: imaginary line from bottom left to top right
    BOOL aboveDownLine = (location.y < (location.x * height / width));
    BOOL aboveUpLine = (location.y < (height - location.x * height / width));
    
    // return Direction based on position relative to lines
    if (aboveDownLine && aboveUpLine) return 0;
    else if (aboveDownLine) return 2;
    else if (aboveUpLine) return 3;
    else return 1;
}

- (void)movePlayer:(Direction)d {
    DRSPosition *curr = self.mazeGrid.player.gridPosition;
    DRSPosition *next = nil;
    switch (d) {
        case 0: // move up
            next = [[DRSPosition alloc] initWithRow:curr.row - 1 andCol:curr.col];
            break;
        case 1: // move down
            next = [[DRSPosition alloc] initWithRow:curr.row + 1 andCol:curr.col];
            break;
        case 2: // move right
            next = [[DRSPosition alloc] initWithRow:curr.row andCol:curr.col + 1];
            break;
        case 3: // move left
            next = [[DRSPosition alloc] initWithRow:curr.row andCol:curr.col - 1];
            break;
        default:
            break;
    }
    [self moveToPosition:next];
}

- (void)moveToPosition:(DRSPosition *)p {
    if (![self.mazeGrid isValidPosition:p]) return;
    DRSGridObject *objectAtPosition = [self.mazeGrid.gridObjects objectForKey:p];
    if (objectAtPosition == nil) {
        // empty, so can move here
        self.mazeGrid.player.gridPosition = p;
        [self.mazeGrid.player removeFromParent];
        [self drawPlayerObject];
    } else if ([objectAtPosition isKindOfClass:[DRSGridTeleport class]]) {
        // move to teleport destination
        DRSGridTeleport *teleport = (DRSGridTeleport *)objectAtPosition;
        DRSGridTeleport *buddyTeleport = teleport.buddyTeleport;
        self.mazeGrid.player.gridPosition = buddyTeleport.gridPosition;
        [self.mazeGrid.player removeFromParent];
        [self drawPlayerObject];
    } else if ([objectAtPosition isKindOfClass:[DRSGridGoal class]]) {
        self.mazeGrid.player.gridPosition = p;
        [self.mazeGrid.player removeFromParent];
        [self drawPlayerObject];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"YOU WIN!"
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"Play again"
                                           otherButtonTitles:nil];
        [av show];
    }
}


@end
