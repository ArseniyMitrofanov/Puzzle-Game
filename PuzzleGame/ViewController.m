#import "ViewController.h"
#import "PuzzleGameEngine.h"
#import "PuzzlePiece.h"
#import "PuzzleGenerator.h"
#import "TransformBoard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _startButton.layer.cornerRadius = 20;
    _appName.layer.cornerRadius = 45;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}


- (IBAction)startGame:(id)sender {
    [self.gameBoard.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [self.gameBoard setBackgroundColor:[UIColor lightGrayColor]];
    UIImage *sample = [UIImage imageNamed:@"notepad_icon_edited.jpg"];
    self.engine = [[PuzzleGameEngine alloc] initEngine:sample withDimension: 4 withSize:self.gameBoard.bounds.size.height];
    [self populateBoard];
    [self.movesCounter setText:@"0"];
    
}

- (void)populateBoard
{
    if(self.gameBoard.subviews != nil)
        [self.gameBoard.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    double pieceSize = self.gameBoard.bounds.size.height / self.engine.dimension;
    for(PuzzlePiece *piece in self.engine.puzzle) {
        piece.frame = CGRectMake(piece.xCurr, piece.yCurr, pieceSize, pieceSize);
        [self.gameBoard addSubview:piece];
    }
}

- (IBAction)move:(id)sender {
    if(sender == self.rightSwipeRecognizer) {
        [self.engine moveRight];
    } else if(sender == self.leftSwipeRecognizer) {
        [self.engine moveLeft];
    } else if(sender == self.upSwipeRecognizer) {
        [self.engine moveUp];
    } else {
        [self.engine moveDown];
    }
    [self.movesCounter setText:[NSString stringWithFormat:@"%d",self.engine.moves]];
    if([self.engine isVictorious]) {
        [self.gameBoard.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [self.gameBoard setBackgroundColor:[UIColor systemBlueColor]];
        UIImageView *winImage =[[UIImageView alloc] initWithFrame:CGRectMake(20,20,332,332)];
        winImage.image=[UIImage imageNamed:@"notepad_icon_rounded.png"];
        [self.gameBoard addSubview:winImage];
    
    }
}

@end
