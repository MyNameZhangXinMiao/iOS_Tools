//
//  JJSlotMachinesViewController.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/9/29.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJSlotMachinesViewController.h"
#import "JJSlotMachinesView.h"



@interface JJSlotMachinesViewController ()
<JJSlotMachinesViewDelegate,
JJSlotMachinesViewDataSource
>



@property (nonatomic, strong) JJSlotMachinesView *slotMachinesView;



@property (nonatomic, strong) NSMutableArray *datas;


@end

@implementation JJSlotMachinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationCustomView.hidden = NO;
    self.navigationCustomView.title = @"老虎机";
    
    [self setupUI];
}
#pragma mark - 初始化界面
- (void)setupUI
{
    self.datas = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [self.datas addObject:img];
    }
    
    _slotMachinesView = [[JJSlotMachinesView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth - 80, 193)];
    _slotMachinesView.center = CGPointMake(kScreenWidth / 2,480);
    _slotMachinesView.delegate = self;
    _slotMachinesView.dataSource = self;
    _slotMachinesView.layer.borderWidth = 1;
    [self.view addSubview:_slotMachinesView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame = CGRectMake(100, kScreenHeight-300, 150, 50);
    [self.view addSubview:btn];
    
}

- (void)buttonClickAction:(UIButton *)button{
    _slotMachinesView.slotResults = [NSArray arrayWithObjects:
                                [NSNumber numberWithInteger:3],
                                [NSNumber numberWithInteger:2],
//                                [NSNumber numberWithInteger:4],
                                nil];
    [self.slotMachinesView startSliding];
    
}

- (NSUInteger)numberOfSlotsInSlotMachine:(JJSlotMachinesView *)slotMachine{
    return 2;
}
- (NSArray *)iconsForSlotsInSlotMachine:(JJSlotMachinesView *)slotMachine{
    return self.datas;
}

@end
