//
//  DrawerViewController.h
//  Drawer
//
//  Created by 吴定如 on 15/10/23.
//  Copyright © 2015年 Dam. All rights reserved.
//

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kMainPageDistance   100   //打开左侧窗时，中视图(右视图)露出的宽度
#define kMainPageScale   0.8  //打开左侧窗时，中视图(右视图）缩放比例
#define kMainPageCenter  CGPointMake(kScreenWidth + kScreenWidth * kMainPageScale / 2.0 - kMainPageDistance, kScreenHeight / 2)  //打开左侧窗时，中视图中心点

#define vCouldChangeDeckStateDistance  (kScreenWidth - kMainPageDistance) / 2.0 - 40 //滑动距离大于此数时，状态改变（关--》开，或者开--》关）
#define vSpeedFloat   0.7    //滑动速度

#define kLeftAlpha 0.9  //左侧蒙版的最大值
#define kLeftCenterX 30 //左侧初始偏移量
#define kLeftScale 0.7 //左侧初始缩放比例

#define vDeckCanNotPanViewTag    987654   // 不响应此侧滑的View的tag

#import <UIKit/UIKit.h>

@interface  DrawerViewController: UIViewController

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (nonatomic, assign) CGFloat speedf;

//左侧视图控制器
@property (nonatomic, strong) UIViewController *leftViewController;

//根视图控制器
@property (nonatomic,strong) UIViewController *rootViewController;

//点击手势控制器，是否允许点击视图恢复视图位置。默认为yes
@property (nonatomic, strong) UITapGestureRecognizer *TapGes;

//滑动手势控制器
@property (nonatomic, strong) UIPanGestureRecognizer *panGes;

//抽屉(侧滑窗) 是否关闭(关闭时显示为主页)
@property (nonatomic, assign) BOOL isClosed;

/*
 初始化侧滑控制器
 leftVC 右视图控制器
 中间视图控制器
 instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andRootView:(UIViewController *)rootVC;

//关闭左侧视图
- (void)closeLeftView;


// 打开左侧视图
- (void)openLeftView;


//设置滑动开关是否开启
//enabled 为YES:支持滑动手势, 为NO:不支持滑动手势
- (void)setPanEnabled: (BOOL)enabled;

@end

