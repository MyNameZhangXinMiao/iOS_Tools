//
//  JJCuteView.m
//  iOS_Tools
//
//  Created by 播呗网络 on 2020/11/30.
//  Copyright © 2020 播呗网络. All rights reserved.
//

#import "JJCuteView.h"


#define kControlMinHeight 100
@interface JJCuteView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIView *controlView;            // 切点,用Q表示
@property (nonatomic, assign) CGFloat controlX;               // 切点x坐标
@property (nonatomic, assign) CGFloat controlY;               // 切点y坐标
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) CGFloat controlHeight;


@property (nonatomic, strong) JJTableView *tableView;

@end
@implementation JJCuteView

static NSString *const kControlX = @"controlX";
static NSString *const kControlY = @"controlY";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 初始化界面
- (void)setupUI{
    
    [self addObserver:self forKeyPath:kControlX options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kControlY options:NSKeyValueObservingOptionNew context:nil];
    
    
    // 手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
//    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:pan];
    
    [self addSubview:self.tableView];
    [self.tableView.panGestureRecognizer addTarget:self action:@selector(handlePanAction:)];

    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kControlMinHeight)];
    [self addSubview:self.navView];
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor colorWithRed:57/255.0 green:67/255.0 blue:89/255.0 alpha:1.0].CGColor;
    [self.navView.layer addSublayer:_shapeLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    
    self.controlX = kScreenWidth/2.0;       // Q点x坐标
    self.controlY = kControlMinHeight;            // Q点y坐标
    _controlView = [[UIView alloc] initWithFrame:CGRectMake(_controlX, _controlY, 3, 3)];
    _controlView.backgroundColor = [UIColor redColor];
    [self addSubview:_controlView];
    
    self.controlHeight = kControlMinHeight;
    _isAnimating = NO;
    
}

- (void)handlePanAction:(UIPanGestureRecognizer *)pan{
    if (!_isAnimating) { //动画过程中不处理事件
        
        if (pan.state == UIGestureRecognizerStateChanged){
            
            CGPoint point = [pan translationInView:self];
            // 这部分代码使Q点跟着手势走
            self.controlHeight = point.y*0.7 + kControlMinHeight;
            self.controlX = kScreenWidth/2.0 + point.x;
            self.controlY = self.controlHeight > kControlMinHeight ? self.controlHeight : kControlMinHeight;
            self.controlView.frame = CGRectMake(self.controlX, self.controlY, self.controlView.frame.size.width, self.controlView.frame.size.height);
            
        }else if (pan.state == UIGestureRecognizerStateCancelled ||
                  pan.state == UIGestureRecognizerStateEnded ||
                  pan.state == UIGestureRecognizerStateFailed){

            //手势结束,_shapeLayer昌盛产生弹簧效果
             _isAnimating = YES;
             _displayLink.paused = NO;           //开启displaylink,会执行方法calculatePath.

             //弹簧
             [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                 self.controlView.frame = CGRectMake(kScreenWidth/2.0, kControlMinHeight, 3, 3);
             } completion:^(BOOL finished) {
                 if(finished){
                     self.displayLink.paused = YES;
                     self.isAnimating = NO;
                 }
             }];
            
            
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}


- (void)updateShapeLayerPath {
    // 更新_shapeLayer形状
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];                              // A点
    [tPath addLineToPoint:CGPointMake(kScreenWidth, 0)];               // B点
    [tPath addLineToPoint:CGPointMake(kScreenWidth,  kControlMinHeight)];  // D点
    [tPath addQuadCurveToPoint:CGPointMake(0, kControlMinHeight) controlPoint:CGPointMake(self.controlX, self.controlY)]; // C,D,Q确定的一个弧线
    [tPath closePath];
    _shapeLayer.path = tPath.CGPath;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kControlX] || [keyPath isEqualToString:kControlY]) {
        [self updateShapeLayerPath];
         
    }
}

- (void)calculatePath{
    // 由于手势结束时,Q执行了一个UIView的弹簧动画,把这个过程的坐标记录下来,并相应的画出_shapeLayer形状
    CALayer *layer = self.controlView.layer.presentationLayer;
    self.controlX = layer.position.x;
    self.controlY = layer.position.y;
    
}


#pragma mark -- TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}




#pragma mark - lazy
- (JJTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[JJTableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}


@end
