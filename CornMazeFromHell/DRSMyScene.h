//
//  DRSMyScene.h
//  CornMazeFromHell
//

//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class DRSMazeGrid;

@interface DRSMyScene : SKScene

@property (nonatomic, strong) DRSMazeGrid *mazeGrid;
@property (nonatomic, strong) SKSpriteNode *mazeGridBounds;
@property (nonatomic) CGFloat squareHeight;

@end
