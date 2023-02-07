

#import <UIKit/UIKit.h>

@interface PuzzlePiece : UIImageView

@property double xDest;
@property double yDest;
@property double xCurr;
@property double yCurr;
@property BOOL movable;

- (PuzzlePiece *)initWithPicture:(UIImage *)image withDestX:(double)destX withDestY:(double)destY;

@end
