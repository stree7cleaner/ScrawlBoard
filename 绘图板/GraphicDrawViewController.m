//
//  ViewController.m
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/27.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicDrawViewController.h"

#import "GraphicBoard.h"

#import <HexColors.h>


@interface GraphicDrawViewController ()
@property (weak, nonatomic) IBOutlet GraphicBoard *board;
@property (weak, nonatomic) IBOutlet UIView *currentColorView;

@end

@implementation GraphicDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    if (self.graphic) {
        self.board.currentGraphic = self.graphic;
        self.currentColorView.backgroundColor = [UIColor hx_colorWithHexRGBAString:self.graphic.currentColorHexStr];
    }
        self.board.currentColor = self.currentColorView.backgroundColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//pop
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击按钮事件
- (IBAction)moveAction:(UIButton *)sender {
    
    sender.tag == 0 ? ({
        [self.board backwards];
    }) : sender.tag == 1 ? ({
        [self.board forwards];
    }) : sender.tag == 2 ? ({
        [self.board clear];
    }) : ({
        [self.board save];
    });
}

//更换画笔颜色
- (IBAction)changeColor:(UIButton *)sender {
    self.currentColorView.backgroundColor = sender.backgroundColor;
    self.board.currentColor = sender.backgroundColor;
}


- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}


@end
