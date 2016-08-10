//
//  KSPhotoZoneViewController.m
//  Akvamarin
//
//  Created by KulikovS on 31.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPhotoZoneViewController.h"
#import "KSPhotoZoneView.h"
#import "KSPhotoZoneViewCell.h"
#import "KSPhotoZoneContext.h"
#import "KSPhotoZone.h"

static NSString * const kKSPhotoZoneBarTitle = @"Фотозоны";

@interface KSPhotoZoneViewController ()
@property (nonatomic, readonly) KSPhotoZoneView     *rootView;
@property (nonatomic, strong)   NSArray             *photoZones;

@end

@implementation KSPhotoZoneViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSPhotoZoneView);

- (NSString *)navigationBarTitle {
    return kKSPhotoZoneBarTitle;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rootView showLoadingViewWithDefaultTextAnimated:YES];
}

#pragma mark -
#pragma mark Private Methods

- (void)contextDidLoad {
    self.photoZones = [KSPhotoZone fetchEntityWithSortDescriptors:nil predicate:nil prefetchPaths:nil];
    KSPhotoZoneView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [rootView removeLoadingViewAnimated:YES];
}

- (void)contextLoadFailed {
    [self contextDidLoad];
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photoZones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSPhotoZoneViewCell *cell = [tableView dequeueReusableCellFromNibWithClass:[KSPhotoZoneViewCell class]];
    [cell fillWithModel:self.photoZones[indexPath.row]];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 //   [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    KSFriendDetailViewController * controller = [KSFriendDetailViewController new];
//    controller.user = self.userFriends[indexPath.row];
//    
//    [self.navigationController pushViewController:controller animated:YES];
//}
@end
