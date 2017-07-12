
//
//  PHLibraryViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/13.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "PHLibraryViewController.h"
#import "PhotoCollectionViewController.h"

@interface PHLibraryViewController ()<UITableViewDelegate,UITableViewDataSource,PHPhotoLibraryChangeObserver>

@property (nonatomic, strong)  PHFetchResult *allPhotos;
@property (nonatomic, strong)  PHFetchResult *smartAlbums;
@property (nonatomic, strong)  PHFetchResult *userCollections;

@property (nonatomic, strong) UITableView *albumsTable;
@property (nonatomic, strong) NSArray *sections;

@end

@implementation PHLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册库";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlbum)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    _sections = [NSArray arrayWithObjects:@"allPhotos", @"smartAlbums",@"userCollections",nil];
    [self.view addSubview:self.albumsTable];
    
    // Do any additional setup after loading the view.
        
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES];
    fetchOptions.sortDescriptors = @[descriptor];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    self.allPhotos = fetchResult;
    self.smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    self.userCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:(id)self];
    
    [self.albumsTable reloadData];
}

- (void)addAlbum{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"new album" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Album Name";
    }];
    UIAlertAction *alerAction = [UIAlertAction actionWithTitle:@"Create "
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                             UITextField *textField = alertVC.textFields.firstObject;
                                                             NSString *title = textField.text;
                                                             if (title && title.length > 0) {
                                                                 
                                                                 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                                                                     [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
                                                                 } completionHandler:^(BOOL success, NSError * _Nullable error) {
                                                                     if (!success) {
                                                                         JY_Log(@"error creating album: %@",error);
                                                                     }
                                                                 }];
                                                                 
                                                             }
    }];
    
    [alertVC addAction:alerAction];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
}

- (UITableView *)albumsTable{
    if (!_albumsTable) {
        _albumsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _albumsTable.delegate = self;
        _albumsTable.dataSource = self;
    }
    return _albumsTable;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger row = 0;
    
    switch (section) {
        case 0:
        {
            row = 1;
        }
            break;
        case 1:
        {
            row = self.smartAlbums.count;
        }
            break;
        case 2:
        {
            row = self.userCollections.count;
        }
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"All Photos";
        }
            break;
        case 1:
        {
            PHCollection *collection = [self.smartAlbums objectAtIndex:indexPath.row];
            cell.textLabel.text = collection.localizedTitle;
        }
            break;

        case 2:
        {
            PHCollection *collection = [self.userCollections objectAtIndex:indexPath.row];
            cell.textLabel.text = collection.localizedTitle;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.sections objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        PhotoCollectionViewController *collectVC = [[PhotoCollectionViewController alloc] init];
        collectVC.fetchResult = self.allPhotos;
        [self.navigationController pushViewController:collectVC animated:YES];
    }
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
   dispatch_sync(dispatch_get_main_queue(), ^{
       
       PHFetchResultChangeDetails *details = [changeInstance changeDetailsForFetchResult:self.allPhotos];
       PHFetchResultChangeDetails *details1 = [changeInstance changeDetailsForFetchResult:self.smartAlbums];
       PHFetchResultChangeDetails *details2 = [changeInstance changeDetailsForFetchResult:self.userCollections];
       if (details) {
           self.allPhotos = details.fetchResultAfterChanges;
       }
       
       if (details1) {
           self.smartAlbums = details.fetchResultAfterChanges;
           [self.albumsTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
       }
       
       if (details2) {
           self.userCollections = details.fetchResultAfterChanges;
           [self.albumsTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
       }
   });
}

- (void)dealloc{
    
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:(id)self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
