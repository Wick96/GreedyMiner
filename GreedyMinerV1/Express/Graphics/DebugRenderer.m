//
//  DebugRenderer.m
//  Express
//
//  Created by Matej Jan on 9.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "DebugRenderer.h"

#import "Express.Math.h"
#import "Express.Scene.h"
#import "Express.Scene.Objects.h"

@implementation DebugRenderer

- (id) initWithGame:(Game *)theGame scene:(id <IScene>)theScene
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		scene = theScene;
		self.itemColor = [Color white];
		self.movementColor = [Color skyBlue];
		self.colliderColor = [Color lime];
		transformMatrix = [[Matrix identity] retain];
	}
	return self;
}

@synthesize itemColor, movementColor, colliderColor;
@synthesize blendState, depthStencilState, rasterizerState, effect, transformMatrix;

- (void) loadContent {
	primitiveBatch = [[PrimitiveBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
	
	Matrix *transformInverse = [Matrix invert:transformMatrix];
	
	Vector2 *topLeft = [Vector2 transform:[Vector2 zero] with:transformInverse];
	Vector2 *bottomRight = [Vector2 transform:[Vector2 vectorWithX:self.graphicsDevice.viewport.width 
																 y:self.graphicsDevice.viewport.height]
										 with:transformInverse];
	
	[primitiveBatch beginWithBlendState:blendState DepthStencilState:depthStencilState 
						RasterizerState:rasterizerState Effect:effect TransformMatrix:transformMatrix];
	
	for (id item in scene) {
		id<IPosition> itemWithPosition = [item conformsToProtocol:@protocol(IPosition)] ? item : nil;
		id<IVelocity> itemWithVelocity = [item conformsToProtocol:@protocol(IVelocity)] ? item : nil;
		id<IRadius> itemWithRadius = [item conformsToProtocol:@protocol(IRadius)] ? item : nil;
		id<IRectangleSize> itemWithRectangleSize = [item conformsToProtocol:@protocol(IRectangleSize)] ? item : nil;
		id<IAAHalfPlaneCollider> aaHalfPlaneCollider = [item conformsToProtocol:@protocol(IAAHalfPlaneCollider)] ? item : nil;
	
		if (itemWithPosition) {
			[primitiveBatch drawPointAt:itemWithPosition.position color:itemColor];
			
			if (itemWithRadius) {
				[primitiveBatch drawCircleAt:itemWithPosition.position radius:itemWithRadius.radius divisions:32 color:itemColor];
			}
			
			if (itemWithRectangleSize) {
				[primitiveBatch drawRectangleAt:itemWithPosition.position
										  width:itemWithRectangleSize.width 
										 height:itemWithRectangleSize.height 
										  color:itemColor];
			}
		}
		
		if (itemWithVelocity) {
			[primitiveBatch drawLineFrom:itemWithPosition.position 
									  to:[Vector2 add:itemWithPosition.position to:itemWithVelocity.velocity]
								   color:movementColor];
		}
		
		if (aaHalfPlaneCollider) {
			AAHalfPlane *aaHPlane = aaHalfPlaneCollider.aaHalfPlane;
			if (aaHPlane.direction == AxisDirectionNegativeX) {
				[primitiveBatch drawLineFrom:[Vector2 vectorWithX:-aaHPlane.distance y:topLeft.y] 
										  to:[Vector2 vectorWithX:-aaHPlane.distance y:bottomRight.y] 
									   color:colliderColor];				
			} else if (aaHPlane.direction == AxisDirectionPositiveX) {
					[primitiveBatch drawLineFrom:[Vector2 vectorWithX:aaHPlane.distance y:topLeft.y] 
											  to:[Vector2 vectorWithX:aaHPlane.distance y:bottomRight.y] 
										   color:colliderColor];
			} else if (aaHPlane.direction == AxisDirectionNegativeY) {
				[primitiveBatch drawLineFrom:[Vector2 vectorWithX:topLeft.x y:-aaHPlane.distance] 
										  to:[Vector2 vectorWithX:bottomRight.x y:-aaHPlane.distance] 
									   color:colliderColor];
			} else {
				[primitiveBatch drawLineFrom:[Vector2 vectorWithX:topLeft.x y:aaHPlane.distance] 
										  to:[Vector2 vectorWithX:bottomRight.x y:aaHPlane.distance] 
									   color:colliderColor];				
			}
		}
	}
	
	[primitiveBatch end];
}

- (void) dealloc
{
	[itemColor release];
	[movementColor release];
	[colliderColor release];
	[primitiveBatch release];
	
	[blendState release];
	[depthStencilState release];
	[rasterizerState release];
	[effect release];
	[transformMatrix release];
	 
	[super dealloc];
}

@end
