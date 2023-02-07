

#import <UIKit/UIKit.h>
@class PuzzleGameEngine;

@interface ViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UIView *appName;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *movesCounter;
@property (weak, nonatomic) IBOutlet UIView *gameBoard;

@property (strong, atomic) PuzzleGameEngine *engine;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *difficultySetterVisibilityToggler;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *downSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *upSwipeRecognizer;


- (IBAction)startGame:(id)sender;
- (IBAction)setDifficultySetterVisibility:(id)sender;
- (IBAction)move:(id)sender;

@end
