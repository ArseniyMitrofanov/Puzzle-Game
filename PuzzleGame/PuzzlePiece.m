

#import "PuzzlePiece.h"

@implementation PuzzlePiece

//@synthesize xCurr;
//@synthesize yCurr;

- (PuzzlePiece *)initWithPicture:(UIImage *)image withDestX:(double)destX withDestY:(double)destY
{
    self = [super initWithImage:image];
    self.xDest = destX;
    self.yDest = destY;
    self.xCurr = destX;
    self.yCurr = destY;
   
    return self;
}

@end
