

#include <time.h>
#include <stdlib.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PuzzleGenerator : NSObject

+ (NSMutableArray *)generatePuzzle:(UIImage *)image withDimension:(int)dimension
                      withFullSize:(double)fullSize;
+ (NSMutableArray *)mix:(NSMutableArray *)array withDimension:(int)dimension withPieceSize:(double)pieceSize;

@end
