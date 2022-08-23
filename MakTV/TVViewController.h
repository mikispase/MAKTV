#import <UIKit/UIKit.h>
#import "AVKit/AVKit.h"


@interface TVViewController : UIViewController
@property (strong, nonatomic) NSMutableArray*televisionDictionary;
@property (nonatomic,strong) AVPlayerViewController *controller;
@property (nonatomic,strong) id currentTVObject;
@end

