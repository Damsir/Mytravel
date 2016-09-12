//
//  DBManager.h
//  Mytravel
//
//  Created by 吴定如 on 15/12/3.
//  Copyright © 2015年 Dam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+ (instancetype)sharedDBManager ;

//插入一条数据
- (BOOL)insertDataWithDictionary:(NSDictionary *)dataDic ;
//删除一条数据
- (BOOL)deleteDataWithDictionary:(NSDictionary *)dataDic ;
//修改数据
- (BOOL)changeDataWithDictionary:(NSDictionary *)dataDic ;

//查询所有数据
- (NSArray *)recieveDBData ;

@end
