#import "Player.h"

@interface HumanPlayer : Player {
    Rectangle *inputArea;
    BOOL grabbing;
    BOOL grabbed;
    Vector2 *touchOffset;
    
    Matrix *inverseView;
}

- (void) setCamera:(Matrix *)camera;
- (void) resetPlayer;

@end
