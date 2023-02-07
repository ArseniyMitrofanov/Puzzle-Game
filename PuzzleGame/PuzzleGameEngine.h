

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PuzzleGameEngine : NSObject

@property int moves;
@property int dimension;
@property int emptyIndex;
@property double pieceSize;
@property (strong, nonatomic) NSMutableArray *puzzle;

- (PuzzleGameEngine *)initEngine:(UIImage *)image withDimension:(int)dimension withSize:(double)size;
- (void)moveUp;
- (void)moveDown;
- (void)moveLeft;
- (void)moveRight;
- (void)undoLastMove;
- (BOOL)isVictorious;

@end
