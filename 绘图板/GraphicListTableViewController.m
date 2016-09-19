//
//  GraphicListTableViewController.m
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicDrawViewController.h"
#import "GraphicListTableViewController.h"

#import "StorageTool.h"
#import "GraphicStorage.h"

#import <ReactiveCocoa.h>
#import <Masonry.h>

#import "NotificationMacro.h"

#import "STProgressView.h"
#import "GraphicListCollectionCell.h"
#import "GraphicCollectionView.h"





@interface GraphicListTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)GraphicCollectionView *collectionView;
@property (nonatomic, strong) NSArray *graphics;

@end

@implementation GraphicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _collectionView             = [GraphicCollectionView collecitonView];
    _collectionView.delegate    = self;
    _collectionView.dataSource  = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[GraphicListCollectionCell class]
            forCellWithReuseIdentifier:[GraphicListCollectionCell cellIdentifier]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
    [self requestGraphics];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:GSGraphicUpdateInDataBaseNotificationKey object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self requestGraphics];
    }];
}


- (void)requestGraphics
{
    if([[self.navigationController viewControllers]lastObject] == self)
    {
        [STProgressView showBlockedStatus:nil];
    }
    
    __weak typeof(*&self) ws = self;
    [StorageTool fetchAllGraphicsWithResult:^(NSArray<GraphicStorage *> *graphics) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [STProgressView dismiss];
            ws.graphics = graphics;
            [ws.collectionView reloadData];
        });
    
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Colletion view data source
//个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.graphics.count;
}

//indexPath对应的数据模型
- (GraphicStorage *)storageAtIndexPath:(NSIndexPath *)indexPath
{
    return _graphics[indexPath.item];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GraphicListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GraphicListCollectionCell cellIdentifier] forIndexPath:indexPath];
    GraphicStorage *graphic         = [self storageAtIndexPath:indexPath];
    [cell configureCellWithObject:graphic];
    
    return cell;
}


#pragma mark - Actions

//编辑涂鸦
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PUSH_GraphiBoard" sender: [self storageAtIndexPath:indexPath]];
}


//新建涂鸦
- (IBAction)newGraphic:(id)sender {
    
    __block NSString * newName = nil;
    
    UIAlertController *alertview = [UIAlertController alertControllerWithTitle:@"新建涂鸦" message:@"请输入名称" preferredStyle:UIAlertControllerStyleAlert];
    [alertview addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertview dismissViewControllerAnimated:NO completion:nil];
        GraphicStorage *graphic = [GraphicStorage new];
        graphic.name = newName;
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"PUSH_GraphiBoard" sender: graphic];
    }]];
    [alertview addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    
    [alertview addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField.rac_textSignal subscribeNext:^(NSString *x) {
            newName = x;
        }];
    }];
    [self.navigationController presentViewController:alertview animated:NO completion:nil];
}




#pragma mark - Navigation
//跳转页面前的
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GraphicDrawViewController *vc = segue.destinationViewController;
    vc.graphic = sender;
}


@end
