#import "TVViewController.h"
#import "AVKit/AVKit.h"
#import "M3U8PlaylistModel.h"


@interface TelevisionViewController : TVViewController

@property (nonatomic,strong) NSString *televisionUrlString;
@property (nonatomic,strong) NSArray *televison;
@property (nonatomic,strong) NSArray *televisonName;

@property (nonatomic) NSInteger index;
@property (nonatomic,strong) UIButton *quality;


@property (nonatomic,strong) AVPlayer *avPlayer;
@property (nonatomic,strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UILabel *televisionName;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) UIImageView *imageView;
@property (nonatomic,strong) M3U8PlaylistModel *m3u8Model;
@property (nonatomic,strong) NSMutableArray *videoArray;
@property (nonatomic,strong) AVPlayerViewController *controller;

@property (nonatomic,strong) id currentIngoModel;


@end
