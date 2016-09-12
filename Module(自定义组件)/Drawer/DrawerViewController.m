//
//  DrawerViewController.m
//  Drawer
//
//  Created by 吴定如 on 15/10/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController()<UIGestureRecognizerDelegate>

{
    CGFloat _scalef;  //实时横向位移
}

@property (nonatomic,strong) UITableView *leftTableview;
@property (nonatomic,assign) CGFloat leftTableviewW;
@property (nonatomic,strong) UIView *contentView;


@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
}

/*
 初始化侧滑控制器
 leftVC 左视图控制器
 mainVC 中间视图控制器
 instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andRootView:(UIViewController *)rootVC
{
    if(self = [super init])
    {
        self.speedf = vSpeedFloat;
        
        self.leftViewController = leftVC;
        self.rootViewController = rootVC;
        
        //滑动手势
        self.panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.rootViewController.view addGestureRecognizer:self.panGes];
        
        [self.panGes setCancelsTouchesInView:YES];
        self.panGes.delegate = self;
        
        
        [self.view addSubview:self.leftViewController.view];
        
        //蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = self.leftViewController.view.bounds;
        view.backgroundColor = [UIColor clearColor];
        view.alpha = 1.0;
        self.contentView = view;
        [self.leftViewController.view addSubview:view];
        
        //获取左侧tableview
        for (UIView *obj in self.leftViewController.view.subviews)
        {
            if ([obj isKindOfClass:[UITableView class]])
            {
                self.leftTableview = (UITableView *)obj;
            }
        }
        
        self.leftTableview.backgroundColor = [UIColor clearColor];
        self.leftTableview.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, kScreenHeight);
        //设置左侧tableview的初始位置和缩放系数
        self.leftTableview.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        
        [self.view addSubview:self.rootViewController.view];
        self.isClosed = YES;//初始时侧滑窗关闭
        
    }
    return self;
}


#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * self.speedf + _scalef);
    
    //是否还需要跟随手指移动
    BOOL needMoveWithTap = YES;
    
    if (((self.rootViewController.view.frame.origin.x <= 0) && (_scalef <= 0)) || ((self.rootViewController.view.frame.origin.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (kScreenWidth - kMainPageDistance)))
    {
        CGFloat recCenterX = rec.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2)
        {
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = rec.view.center.y;
        
        rec.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - kMainPageScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
       // NSLog(@"%f",leftTabCenterX);
        
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftTableview.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (rec.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
        
    }
    else
    {
        //超出范围，
        if (self.rootViewController.view.frame.origin.x < 0)
        {
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.rootViewController.view.frame.origin.x > (kScreenWidth - kMainPageDistance))
        {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded)
    {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.isClosed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.isClosed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}


#pragma mark - 单击手势

-(void)handeTap:(UITapGestureRecognizer *)tap
{
    
    if ((!self.isClosed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        //抽屉动画效果
        [UIView animateWithDuration:0.5 animations:^{
       
            tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
            tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
            self.isClosed = YES;
        
            self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
            self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
            self.contentView.alpha = kLeftAlpha;
        }];
    
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置

//关闭左视图
- (void)closeLeftView
{
    //抽屉动画效果
    [UIView animateWithDuration:0.5 animations:^{
    
        self.rootViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        self.rootViewController.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        self.isClosed = YES;
        
        self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.contentView.alpha = kLeftAlpha;

    }];
    
    [self removeSingleTap];
}

#pragma mark -- 打开左视图

- (void)openLeftView;
{
    //抽屉动画效果
    [UIView animateWithDuration:0.5 animations:^{
        
        self.rootViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,kMainPageScale,kMainPageScale);
        self.rootViewController.view.center = kMainPageCenter;
        self.isClosed = NO;
        
        self.leftTableview.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        self.contentView.alpha = 0;
    }];
    
    [self disableTapButton];
}

#pragma mark - 行为收敛控制

- (void)disableTapButton
{
    for (UIButton *tempButton in [self.rootViewController.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.TapGes)
    {
        //单击手势
        self.TapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.TapGes setNumberOfTapsRequired:1];
        
        [self.rootViewController.view addGestureRecognizer:self.TapGes];
        self.TapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

#pragma mark -- 关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.rootViewController.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.rootViewController.view removeGestureRecognizer:self.TapGes];
    self.TapGes = nil;
}


//设置滑动开关是否开启
//enabled 为YES:支持滑动手势, 为NO:不支持滑动手势
- (void)setPanEnabled: (BOOL) enabled
{
    [self.panGes setEnabled:NO];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
        //NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
        //NSLog(@"响应侧滑");
        return YES;
    }
}


@end
