//
//  DRSGridObject.h
//  CornMazeFromHell
//
//  Created by Dan Schlosser on 7/22/13.
//  Copyright (c) 2013 Dan Schlosser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "DRSPosition.h"


@interface DRSGridObject : SKSpriteNode

@property (nonatomic) BOOL solid;
@property (nonatomic, strong) DRSPosition *gridPosition;

@end
