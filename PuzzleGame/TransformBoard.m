

#import "TransformBoard.h"
#import "PuzzleGameEngine.h"
#import "PuzzlePiece.h"

@interface TransformBoard () {
    int _xDir;
    int _yDir;
    int _dimension;
    NSMutableArray *_puzzle;
    int _emptyIndex;
    double _pieceSize;
}

- (void)swapIndex:(int)first withIndex:(int)second;

@end

@implementation TransformBoard

- (TransformBoard *)initWithEngine:(PuzzleGameEngine *)engine withXDir:(int)xDir withYDir:(int)yDir
{
    _xDir = xDir;
    _yDir = yDir;
    _dimension = [engine dimension];
    _puzzle = [engine puzzle];
    _emptyIndex = [engine emptyIndex];
    _pieceSize = [engine pieceSize];
    return self;
}

- (NSMutableArray *)transform
{
    PuzzlePiece *emptyPiece = [_puzzle objectAtIndex:_emptyIndex];
    int newIndex;
    if(_xDir == 0)
        
        newIndex = (_emptyIndex+(_dimension*_yDir));

    else if(_yDir == 0)
        newIndex = (_emptyIndex-_xDir);
    else
        return _puzzle;
    
    PuzzlePiece *nonEmptyPiece = [_puzzle objectAtIndex:newIndex];
    double x1 = [emptyPiece xCurr];
    double y1 = [emptyPiece yCurr];
    double x2 = [nonEmptyPiece xCurr];
    double y2 = [nonEmptyPiece yCurr];
    
    CGRect destRect = CGRectMake(x1, y1, _pieceSize, _pieceSize);
    CGRect sourceRect = CGRectMake(x2, y2, _pieceSize, _pieceSize);
    
    nonEmptyPiece.frame = destRect;
    emptyPiece.frame = sourceRect;
    
    [nonEmptyPiece setXCurr:x1];
    [nonEmptyPiece setYCurr:y1];
    [emptyPiece setXCurr:x2];
    [emptyPiece setYCurr:y2];
    
    [self swapIndex:_emptyIndex withIndex:newIndex];
    
    return _puzzle;
}

- (void)swapIndex:(int)first withIndex:(int)second
{
    PuzzlePiece *temp = [_puzzle objectAtIndex:first];
    [_puzzle replaceObjectAtIndex:first withObject:[_puzzle objectAtIndex:second]];
    [_puzzle replaceObjectAtIndex:second withObject:temp];
}

@end

