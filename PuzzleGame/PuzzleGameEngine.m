

#import "PuzzleGameEngine.h"
#import "TransformBoard.h"
#import "PuzzleGenerator.h"
#import "PuzzlePiece.h"

@interface PuzzleGameEngine () {
    double _boardSize;
    PuzzlePiece *_emptyPiece;
    TransformBoard *_transform;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(double)size;
- (int)findEmptyPiece;

@end

@implementation PuzzleGameEngine

- (PuzzleGameEngine *)initEngine:(UIImage *)image withDimension:(int)dimension withSize:(double)size
{
    _boardSize = size;
    self.dimension = dimension;
    int pieceCount = (int)pow(dimension, 2);
    self.moves = 0;
    UIImage *newImage = [self scaleImage:image toSize:size];
    NSMutableArray *puzzle = [PuzzleGenerator generatePuzzle:newImage withDimension:dimension withFullSize:size];
    _emptyPiece = [puzzle objectAtIndex:(pieceCount-1)];
    self.puzzle = [PuzzleGenerator mix:puzzle withDimension:dimension withPieceSize:(size/dimension)];
    self.emptyIndex = [self findEmptyPiece];
    self.pieceSize = _boardSize / dimension;
    return self;
}

- (void)moveUp
{
    
    _transform = [[TransformBoard alloc] initWithEngine:self withXDir:0 withYDir:1];
    if(_emptyIndex / _dimension == (_dimension-1)) return;
    self.puzzle = [_transform transform];
    self.emptyIndex = [self findEmptyPiece];
    _moves ++;
}

- (void)moveDown
{
    
    _transform = [[TransformBoard alloc] initWithEngine:self withXDir:0 withYDir:-1];
    if(_emptyIndex / _dimension == 0) return;
    self.puzzle = [_transform transform];
    self.emptyIndex = [self findEmptyPiece];
    _moves ++;
}

- (void)moveLeft
{
    _transform = [[TransformBoard alloc] initWithEngine:self withXDir:-1 withYDir:0];
    if(_emptyIndex % _dimension == (_dimension-1)) return;
    self.puzzle = [_transform transform];
    self.emptyIndex = [self findEmptyPiece];
    _moves ++;
}

- (void)moveRight
{
    
    _transform = [[TransformBoard alloc] initWithEngine:self withXDir:1 withYDir:0];
    if(_emptyIndex % _dimension == 0) return;
    self.puzzle = [_transform transform];
    self.emptyIndex = [self findEmptyPiece];
    _moves ++;
}


- (UIImage *)scaleImage:(UIImage *)image toSize:(double)size
{
    CGRect rect = CGRectMake(0, 0, size, size);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(newImage);
    UIImage *finalImage = [UIImage imageWithData:imageData];
    return finalImage;
}

- (int)findEmptyPiece
{
    int i = 0;
    for(PuzzlePiece *piece in _puzzle) {
        if([piece isEqual:_emptyPiece]) return i;
        i++;
    }
    return -1;
}

- (BOOL)isVictorious
{
    for(PuzzlePiece *piece in _puzzle) {
        if([piece xCurr] != [piece xDest] || [piece yCurr] != [piece yDest])
            return NO;
    }
    return YES;
}

@end
