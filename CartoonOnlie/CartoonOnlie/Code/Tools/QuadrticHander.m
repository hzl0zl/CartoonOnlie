//
//  QuadrticHander.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadrticHander.h"
#import "FMDB.h"
#import "QuadraticModel.h"

@interface QuadrticHander ()

@property (nonatomic,strong) FMDatabase *db;

@end


@implementation QuadrticHander

#pragma mark 获取数据
-(NSString *)dataPath
{
    //获取路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    //创建文件
    NSString *file = [path stringByAppendingPathComponent:@"quadrtic.sqlite"];
    
    return file;
}


#pragma mark 初始化单例

+(QuadrticHander *)shareHandler
{
    static QuadrticHander *quadrtic = nil;
    if (quadrtic == nil) {
        
        quadrtic = [[QuadrticHander alloc]init];
    }
    return quadrtic;
}

#pragma mark 初始化创建表

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.db = [FMDatabase databaseWithPath:[self dataPath]];
        
        if ([self.db open]) {
            
            NSString *sql = @"create table if not exists Quadrtic(q_id integer primary key, q_cover_image_url text, q_url text, q_label_text text, q_title text, q_nickname text)";
            [self.db executeUpdate:sql];
        }
        [self.db close];
    }
    
    return self;
}

#pragma mark 添加数据保存至本地

-(BOOL)saveData:(QuadraticModel *)modelData
{
    if ([self.db open]) {
        
        [self.db executeUpdate: @"insert into Quadrtic(q_cover_image_url,q_url,q_label_text,q_title,q_nickname)values(?,?,?,?,?)",modelData.cover_image_url,modelData.url,modelData.label_text,modelData.title,modelData.nickname];
        [self.db close];
        
        return YES;
    
    }
    [self.db close];
    return NO;
}

#pragma mark 查询
-(NSMutableArray *)allData
{
    if ([self.db open]) {
        NSMutableArray *mArry = [[NSMutableArray alloc]init];
        FMResultSet *result =[self.db executeQuery: @"select *from Quadrtic"];
        while ([result next]) {
            QuadraticModel *model = [[QuadraticModel alloc]init];
            
            model.cover_image_url = [result stringForColumn:@"q_cover_image_url"];
            model.url = [result stringForColumn:@"q_url"];
            model.label_text = [result stringForColumn:@"q_label_text"];
            model.nickname = [result stringForColumn:@"q_nickname"];
            model.title = [result stringForColumn:@"q_title"];
            
            [mArry addObject:model];
        }
        [self.db close];
        return mArry;
        
    }
    [self.db close];
    return nil;
}

@end
