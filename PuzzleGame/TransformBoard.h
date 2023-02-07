

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PuzzleGameEngine;

@interface TransformBoard : NSObject

- (TransformBoard *)initWithEngine:(PuzzleGameEngine *)engine withXDir:(int)xDir withYDir:(int)yDir;
- (NSMutableArray *)transform;
- (NSMutableArray *)doInverse;

@end
