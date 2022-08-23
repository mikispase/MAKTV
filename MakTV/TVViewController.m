
#import "TVViewController.h"
#import "CellClass.h"
#import "TelevisionViewController.h"
#import "AVKit/AVKit.h"
#import "MakTV-Swift.h"


@interface TVViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

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
    self.televisionDictionary =  [NSMutableArray new];
    
    
    //Sitel
    TVObject *sitel = [[TVObject alloc] initWithImageName:@"sitel" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Sitel)/index.m3u8"]];
    [self.televisionDictionary addObject:sitel];
    
    TVObject *kanal5 = [[TVObject alloc] initWithImageName:@"kanal5" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Kanal_5)/index.m3u8"]];
    [self.televisionDictionary addObject:kanal5];
    
    
    TVObject *telma = [[TVObject alloc] initWithImageName:@"telma" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Telma)/index.m3u8"]];
    [self.televisionDictionary addObject:telma];
    
    
    TVObject *alfa = [[TVObject alloc] initWithImageName:@"alfa" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Alfa)/index.m3u8"]];
    [self.televisionDictionary addObject:alfa];
    
    
    TVObject *mrt = [[TVObject alloc] initWithImageName:@"mrt" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(MRT_1)/index.m3u8"]];
    [self.televisionDictionary addObject:mrt];
    
    
    TVObject *vesti = [[TVObject alloc] initWithImageName:@"24vesti" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(TV_24)/index.m3u8"]];
    [self.televisionDictionary addObject:vesti];
    
    TVObject *nasaTv = [[TVObject alloc] initWithImageName:@"nasa-tv" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(TV_24)/index.m3u8"]];
    [self.televisionDictionary addObject:nasaTv];
    
    
    TVObject *alsat = [[TVObject alloc] initWithImageName:@"alsat" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(Alsat_M)/index.m3u8"]];
    [self.televisionDictionary addObject:alsat];
    
    
    TVObject *era = [[TVObject alloc] initWithImageName:@"era" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(ERA)/index.m3u8"]];
    [self.televisionDictionary addObject:era];
    
    
    TVObject *dvaesetIeden = [[TVObject alloc] initWithImageName:@"21tv" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(TV21)/index.m3u8"]];
    [self.televisionDictionary addObject:dvaesetIeden];
    
    TVObject *mtmSkopska = [[TVObject alloc] initWithImageName:@"mtmSkopska" url:[NSURL URLWithString:@"https://vipottbpkstream.vip.hr/Content/onevip-hls/Live/Channel(MTM)/index.m3u8"]];
    [self.televisionDictionary addObject:mtmSkopska];
    

    [self.collectionView reloadData];

}

#pragma mark - CollectionView Delegates and Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.televisionDictionary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
    TVObject *obj = (TVObject *)self.televisionDictionary[indexPath.row];
    UIImage *image = [UIImage imageNamed:obj.imageName];
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
    
    
    if (Constants.isCustomPlayerEnabled) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TelevisionViewController *myVC = (TelevisionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TelevisionViewController"];
        TVObject *model = (TVObject *)self.televisionDictionary[indexPath.row];
        myVC.televisionUrlString = model.url.absoluteString;
        myVC.televison = [self televisionUrlStrings];
        myVC.televisonName = [self televisionName];
        myVC.index = indexPath.row;
        [self presentViewController:myVC animated:YES completion:nil];
    }else {
          [self presentPplayerWithIndexPath:indexPath];
    }
    
   
}

@end
