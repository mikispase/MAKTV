
#import "TVViewController.h"
#import "CellClass.h"
#import "TelevisionViewController.h"

@interface TVViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSDictionary *televisionDictionary;

@end

@implementation TVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCollectionView];
    
    [self prepareTelevisions];
    
}

#pragma mark - Prepare Collection View Tvs

-(void)addCollectionView{
    [self.collectionView registerClass:[CellClass class] forCellWithReuseIdentifier:@"classCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setItemSize:CGSizeMake(230, 250)];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.minimumInteritemSpacing = 50;
    self.flowLayout.minimumLineSpacing = 250;

    [self.collectionView setCollectionViewLayout:self.flowLayout];
    self.collectionView.bounces = NO;
    [self.collectionView setShowsHorizontalScrollIndicator:YES];
    [self.collectionView setShowsVerticalScrollIndicator:YES];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark - Prepare data of Tv's

-(void)prepareTelevisions{
    self.televisionDictionary = [NSDictionary dictionary];
    self.televisionDictionary = @{@"sitel": @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Sitel)/index.m3u8",
                                  @"kanal5" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Kanal_5)/index.m3u8",
                                  @"telma" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Telma)/index.m3u8",
                                  @"alfa" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Alfa)/index.m3u8",
                                  @"mrt" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(MRT_1)/index.m3u8",
                                  @"24vesti" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(TV_24)/index.m3u8",
                                  @"nasa-tv" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Nasha_TV)/index.m3u8",
                                  @"era" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(ERA)/index.m3u8",
                                  @"21tv" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(TV21)/index.m3u8",
                                  @"mtmSkopska" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(MTM)/index.m3u8",
                                  @"alsat" : @"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Alsat_M)/index.m3u8",
                                
                                  };
    [self.collectionView reloadData];

}

#pragma mark - CollectionView Delegates and Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.televisionDictionary.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
    NSArray *keyArray = [self.televisionDictionary allKeys];
    UIImage *image = [UIImage imageNamed:keyArray[indexPath.row]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.adjustsImageWhenAncestorFocused = YES;
    imageView.frame = CGRectMake(16, 16, 230 , 250);
    imageView.clipsToBounds = YES;
    cell.contentView.backgroundColor = [UIColor clearColor];
    imageView.backgroundColor = [UIColor clearColor];
    [cell addSubview:imageView];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self presentTV:indexPath];
}

#pragma mark - Present Tv's View Controller

- (void)presentTV:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TelevisionViewController *myVC = (TelevisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TelevisionViewController"];
    myVC.televisionUrlString = [self.televisionDictionary allValues][indexPath.row];
    myVC.televison = [self.televisionDictionary allValues];
    myVC.televisonName = [self.televisionDictionary allKeys];
    myVC.index = indexPath.row;
    [self presentViewController:myVC animated:YES completion:nil];

}

@end
