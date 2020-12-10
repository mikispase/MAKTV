#import "TelevisionViewController.h"
#import  <AVFoundation/AVPlayer.h>
#import  <AVFoundation/AVPlayerLayer.h>

@interface TelevisionViewController () <UIGestureRecognizerDelegate>{
    int findTelevision;
}
@property (nonatomic,strong) AVPlayer *avPlayer;
@property (nonatomic,strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UILabel *televisionName;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) UIImageView *imageView;

@end

@implementation TelevisionViewController

@synthesize tapRecognizer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addGesuresRecognizers];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50 ,self.view.frame.size.height/2-100, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"LED-TV-PNG"];
    [self.view addSubview:self.imageView];
    
    [self changeTv:self.televisionUrlString];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationIsActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationEnteredForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)addGesuresRecognizers
{
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.allowedPressTypes = @[[NSNumber numberWithInteger:UIPressTypeMenu],
                                        [NSNumber numberWithInteger:UIPressTypePlayPause],
                                        [NSNumber numberWithInteger:UIPressTypeUpArrow],
                                        [NSNumber numberWithInteger:UIPressTypeUpArrow]];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedRight:)]; swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    
    UISwipeGestureRecognizer* swipeRecognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swippedLeft:)]; swipeRecognizerLeft.direction =UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizerLeft];
    
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press;{
    if (press.type == UIPressTypePlayPause)
    {
        if ((self.avPlayer.rate != 0) && (self.avPlayer.error == nil))
        {
            [self.avPlayer pause];
        }
        else
        {
            [self.avPlayer play];
        }
    }
    else if (press.type == UIPressTypeMenu)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
}

- (void)handleTap:(UITapGestureRecognizer *)sender{
   
}

- (void)applicationIsActive:(NSNotification *)notification{
    [self.avPlayer play];
}

- (void)applicationEnteredForeground:(NSNotification *)notification{
    [self.avPlayer pause];
}


-(void)swippedRight:(UISwipeGestureRecognizer *)recognizer{
    if (self.index !=self.televison.count-1) {
        self.index++;
        self.televisionName.text = @"";
        if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            [self changeTv:self.televison[self.index]];
        }
    }
}
-(void)swippedLeft:(UISwipeGestureRecognizer *)recognizer{
    
    if (self.index != 0) {
        self.televisionName.text = @"";
        self.index--;
        if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft){
            [self changeTv:self.televison[self.index]];
        }
    }
}

-(void)changeTv:(NSString *)strUrlString{
    
    [self.avPlayer pause];
    [self.avPlayerLayer removeFromSuperlayer];
    self.avPlayer = nil;
    
    self.avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:strUrlString]];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:self.avPlayerLayer];
    [self.avPlayer play];
    
    self.televisionName = [[UILabel alloc]initWithFrame:CGRectMake(70, self.view.frame.size.height-100, 200, 100)];
    self.televisionName.text = self.televisonName[self.index];
    self.imageView.image = [UIImage imageNamed:self.televisonName[self.index]];

    self.televisionName.textColor = [UIColor blackColor];
    [self.view addSubview:self.televisionName];
}

@end
