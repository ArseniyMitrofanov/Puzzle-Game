

#import "PuzzleGenerator.h"
#import "PuzzlePiece.h"

@interface PuzzleGenerator ()

+ (UIImage *)createPiece:(UIImage *)image fromX:(double)x fromY:(double)y withSize:(double)size;

@end

@implementation PuzzleGenerator
+ (NSMutableArray *)generatePuzzle:(UIImage *)image withDimension:(int)dimension
                      withFullSize:(double)fullSize
{
    int pieceCount = (int)pow(dimension, 2);
    double pieceSize = fullSize / dimension;
    NSMutableArray *puzzle = [[NSMutableArray alloc] initWithCapacity:pieceCount];
    for(int i = 0; i < pieceCount; i++) {
        double x = i % dimension;
        double y = i / dimension;
        UIImage *subset = [PuzzleGenerator createPiece:image fromX:x*pieceSize fromY:y*pieceSize withSize:pieceSize];
        PuzzlePiece *piece = [[PuzzlePiece alloc] initWithPicture:subset withDestX:x*pieceSize withDestY:y*pieceSize];
        [puzzle addObject:piece];
    }
    PuzzlePiece *emptyPiece = [[PuzzlePiece alloc] initWithPicture:[[UIImage alloc] init] withDestX:pieceSize*(dimension-1) withDestY:pieceSize*(dimension-1)];
    [puzzle replaceObjectAtIndex:(pieceCount-1) withObject:emptyPiece];
    return puzzle;
}

+ (NSMutableArray *)mix:(NSMutableArray *)array withDimension:(int)dimension withPieceSize:(double)pieceSize
{
    NSMutableArray *puzzle = [[NSMutableArray alloc] init];
    int lineWithEmptyPiece = 0;
    int pairs = 0;
    int max = (int)[array count];
    int pieceCount = (int)pow(dimension, 2);
        for(int i = 0; i < max; i++) {
            int a = arc4random() % (max-i);
            double x = (i % dimension) * pieceSize;
            double y = (i / dimension) * pieceSize;
            PuzzlePiece *piece = [array objectAtIndex:a];
            [piece setXCurr:x];
            [piece setYCurr:y];
            [puzzle addObject:piece];
            [array removeObject:piece];
        }
        for(int i = 0; i < pieceCount; i++) {
            PuzzlePiece *currPiece = puzzle[i];
            if ((currPiece.xDest == pieceSize*(dimension-1))&&(currPiece.yDest == pieceSize*(dimension-1))){
                lineWithEmptyPiece = (i/dimension)+1;
            }else{
                for(int j = i; j < pieceCount; j++){
                    PuzzlePiece * nextPiece = puzzle[j];
                    if ((currPiece.yDest >  nextPiece.yDest)||((currPiece.yDest ==  nextPiece.yDest)&&(currPiece.xDest >  nextPiece.xDest))){
                        pairs += 1;
                    }
                }
            }
        }
        if(((pairs + lineWithEmptyPiece)%2) == 0){
        }else{
            PuzzlePiece *piece0 = puzzle[0];
            PuzzlePiece *piece1 = puzzle[1];
            double temp = 0;
            temp = piece0.xCurr;
            piece0.xCurr = piece1.xCurr;
            piece1.xCurr = temp;
            temp =  piece1.yCurr;
            piece1.yCurr = piece0.yCurr;
            piece0.yCurr= temp;
            [puzzle replaceObjectAtIndex:0 withObject:piece1];
            [puzzle replaceObjectAtIndex:1 withObject:piece0];
        }
    return puzzle;
}

+ (UIImage *)createPiece:(UIImage *)image fromX:(double)x fromY:(double)y withSize:(double)size
{
    CGRect rect = CGRectMake(x,y,size,size);
    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage,rect);
    UIImage *finalImage = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return finalImage;
}
@end
