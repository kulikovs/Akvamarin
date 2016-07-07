//
//  KSUserTableViewController.m
//  KSIdapStudy
//
//  Created by KulikovS on 03.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSUserViewController.h"
#import "KSUserView.h"
#import "KSArrayModel.h"
#import "KSUserViewCell.h"
#import "KSStringModel.h"
#import "KSStateModel.h"
#import "KSArrayModelManager.h"

static NSString * const kKSStringForRemoveButton = @"Remove";

@interface KSUserViewController ()
@property (nonatomic, readonly) KSUserView *rootView;

- (void)performChangeWithObject:(KSStateModel *)object;
- (void)load;
- (void)addHandlers;

@end

@implementation KSUserViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSUserView);

-(void)setArrayModel:(KSArrayModel *)arrayModel {
    if (_arrayModel != arrayModel) {
        _arrayModel = arrayModel;
        
        [self addHandlers];
        [self load];
    }
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self load];
}

#pragma mark -
#pragma mark Private Methods

- (void)load {
    [self.rootView showLoadingViewWithDefaultTextAnimated:YES];
    [self.arrayModel load];
}

- (void)addHandlers {
    KSWeakifySelfWithClass(KSUserViewController);
    [self.arrayModel addHandler:^(KSStateModel *object) {
        KSStrongifySelfWithClass(KSUserViewController);
        [strongSelf performChangeWithObject:object];
    }
                      state:kKSModelStateChanged
                     object:self];
    
    [self.arrayModel addHandler:^(KSStateModel *object) {
        KSStrongifySelfWithClass(KSUserViewController);
       KSUserView *rootView = strongSelf.rootView;
        [rootView.tableView reloadData];
        [rootView removeLoadingViewAnimated:YES];
    }
                      state:kKSModelStateLoaded
                     object:self];
}

- (void)performChangeWithObject:(KSStateModel *)object {
    UITableView *tableView = self.rootView.tableView;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:object.index inSection:0];
    if (object.state == kKSStateModelRemoveState) {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark -
#pragma mark Handling

- (IBAction)onEditTable:(id)sender {
    KSUserView *rootView = self.rootView;
    rootView.tableView.editing = !rootView.editTableSwitch.on;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayModel.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    KSUserViewCell *cell = [tableView dequeueReusableCellFromNibWithClass:[KSUserViewCell class]];
//    [cell fillWithModel:self.arrayModel[indexPath.row]];
//    
//    return cell;
//}

- (void)        tableView:(UITableView *)tableView
       commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    KSArrayModel *model = self.arrayModel;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [model removeObjectAtIndex:indexPath.row];
    } else {
        [model addObject:[KSStringModel new]];
    }
}

- (NSString *)                              tableView:(UITableView *)tableView
    titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kKSStringForRemoveButton;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)            tableView:(UITableView *)tableView
           moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
                  toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.arrayModel moveObjectAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

@end
