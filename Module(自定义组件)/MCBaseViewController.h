//
//  MCBaseViewController.h
//  Mytravel
//
//  Created by 吴定如 on 15/11/19.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCNetWorkingViewController.h"

//数据源刷新完成回调
typedef void (^freshDataBlock)(BOOL isSuccess,NSError *error);

@interface MCBaseViewController : MCNetWorkingViewController

//tableView
@property(nonatomic,strong) UITableView *MCTable;

//刷新数据的数组
@property(nonatomic,strong) NSMutableArray *dataArray;
//管理page页面数
@property(nonatomic,assign) int page;
//控制器可访问的数据链接
@property(nonatomic,strong) NSString *url;
//区分是哪个控制器传过来的
@property(nonatomic,assign) NSInteger index;


//下拉刷新,上拉加载更多
-(void)headerRefresh;
-(void)footerLoadMore;


//刷新数据源
-(void)loadYouQuNetDataInfo:(freshDataBlock)block ;
//加载更多
-(void)loadMoreYouQuNetDataToInfo:(freshDataBlock)block;

//导航栏标题
-(void)initNavigationBarTitle:(NSString *)title;

@end

