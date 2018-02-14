#import "Artificial.Mirage.h"

#import "Express.Scene.Objects.h"
#import "Express.Scene.h"

#import "Express.Graphics.h"

@interface Button : NSObject <ISceneUser> {
    id<IScene> scene;
    
    Image *backgroundImage;
    Label *label;
    
    Rectangle *inputArea;
    BOOL enabled;
    
    BOOL isDown;
    BOOL wasPressed;
    BOOL wasReleased;
    int pressedID;
    
    Color *labelColor, *labelHoverColor, *backgroundColor, *backgroundHoverColor;
}

- (id) initWithInputArea:(Rectangle*)theInputArea background:(Texture2D*)background font:(SpriteFont *)font text:(NSString *)text;

@property (nonatomic, readonly) Rectangle *inputArea;
@property (nonatomic) BOOL enabled;

@property (nonatomic, readonly) BOOL isDown;
@property (nonatomic, readonly) BOOL wasPressed;
@property (nonatomic, readonly) BOOL wasReleased;

@property (nonatomic, readonly) Image *backgroundImage;
@property (nonatomic, readonly) Label *label;

@property (nonatomic, retain) Color *labelColor, *labelHoverColor, *backgroundColor, *backgroundHoverColor;

- (void) updateWithInverseView:(Matrix*)inverseView;

@end
