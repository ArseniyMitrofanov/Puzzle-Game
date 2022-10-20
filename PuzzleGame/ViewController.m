#import "ViewController.h"
#import "SBPuzzleGameEngine.h"
#import "SBPuzzlePiece.h"
#import "SBPuzzleinator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    self.engine.moves--;
    [self.engine undoLastMove];
    [self.movesCounter setText:[NSString stringWithFormat:@"%d",self.engine.moves]];
}

- (IBAction)startGame:(id)sender {
    if([[self.gameBoard backgroundColor] isEqual:[UIColor systemBlueColor]]) {
        [self.gameBoard setBackgroundColor:[UIColor lightGrayColor]];
    }
    UIImage *sample = [UIImage imageNamed:@"notepad_icon_edited.jpg"];
    self.engine = [[SBPuzzleGameEngine alloc] initEngine:sample withDimension: 4 withSize:self.gameBoard.bounds.size.height];
    [self populateBoard];
    [self.movesCounter setText:@"0"];
    
}

- (void)populateBoard
{
    if(self.gameBoard.subviews != nil)
        [self.gameBoard.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    double pieceSize = self.gameBoard.bounds.size.height / self.engine.dimension;
    for(SBPuzzlePiece *piece in self.engine.puzzle) {
        piece.frame = CGRectMake(piece.xCurr, piece.yCurr, pieceSize, pieceSize);
        [self.gameBoard addSubview:piece];
    }
}

- (IBAction)move:(id)sender {
    
    self.engine.moves++;
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
    }
}

@end
