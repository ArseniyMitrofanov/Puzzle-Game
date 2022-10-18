//
//  SBPuzzleinator.m
//  CatPuzzle
//
//  Created by Samuel Bowman on 6/11/17.
//  Copyright © 2017 Samuel Bowman. All rights reserved.
//

#import "SBPuzzleinator.h"
#import "SBPuzzlePiece.h"

@interface SBPuzzleinator ()

+ (UIImage *)createPiece:(UIImage *)image fromX:(double)x fromY:(double)y withSize:(double)size;

@end

@implementation SBPuzzleinator
+ (NSMutableArray *)generatePuzzle:(UIImage *)image withDimension:(int)dimension
                      withFullSize:(double)fullSize
{
    int pieceCount = (int)pow(dimension, 2);
    double pieceSize = fullSize / dimension;
    NSMutableArray *puzzle = [[NSMutableArray alloc] initWithCapacity:pieceCount];
    for(int i = 0; i < pieceCount; i++) {
        double x = i % dimension;
        double y = i / dimension;
        UIImage *subset = [SBPuzzleinator createPiece:image fromX:x*pieceSize fromY:y*pieceSize withSize:pieceSize];
        SBPuzzlePiece *piece = [[SBPuzzlePiece alloc] initWithPicture:subset withDestX:x*pieceSize withDestY:y*pieceSize];
        [puzzle addObject:piece];
    }
    SBPuzzlePiece *emptyPiece = [[SBPuzzlePiece alloc] initWithPicture:[[UIImage alloc] init] withDestX:pieceSize*(dimension-1) withDestY:pieceSize*(dimension-1)];
    [puzzle replaceObjectAtIndex:(pieceCount-1) withObject:emptyPiece];
    return puzzle;
}

+ (NSMutableArray *)fisherYates:(NSMutableArray *)array withDimension:(int)dimension withPieceSize:(double)pieceSize
{
    int lineWithEmptyPiece = 0;
    bool isDefective = true;
    int pairs = 0;
    int max = (int)[array count];
    int pieceCount = (int)pow(dimension, 2);
    NSMutableArray *puzzle = [[NSMutableArray alloc] init];
//    do {
        for(int i = 0; i < max; i++) {
            int a = arc4random() % (max-i);
            double x = (i % dimension) * pieceSize;
            double y = (i / dimension) * pieceSize;
            SBPuzzlePiece *piece = [array objectAtIndex:a];
            [piece setXCurr:x];
            [piece setYCurr:y];
            [puzzle addObject:piece];
            [array removeObject:piece];
        }
        for(int i = 0; i < pieceCount; i++) {
            SBPuzzlePiece *currPiece = puzzle[i];
            if ((currPiece.xDest == pieceSize*(dimension-1))&&(currPiece.yDest == pieceSize*(dimension-1))){
                lineWithEmptyPiece = (i/dimension)+1;
            }else{
                for(int j = i; j < pieceCount; j++){
                    SBPuzzlePiece * nextPiece = puzzle[j];
                    if ((currPiece.yDest >  nextPiece.yDest)||((currPiece.yDest ==  nextPiece.yDest)&&(currPiece.xDest >  nextPiece.xDest))){
                        pairs += 1;
                    }
                }
            }
        }
        if(((pairs + lineWithEmptyPiece)%2) == 0){
            isDefective = false;
            printf("1 ");
        }else{
            isDefective = true;
            printf("0 ");
        }
//    }while(isDefective == true);
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
