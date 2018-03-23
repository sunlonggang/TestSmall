//
//  SmallModel.m
//  TestSmall
//
//  Created by slg on 2018/3/20.
//  Copyright © 2018年 slg. All rights reserved.
//

#import "SmallModel.h"

@implementation SmallModel

-(NSMutableArray*)rows{
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

-(void)parse:(NSDictionary*)dic{
    self.title = dic[@"title"];
    NSArray* array = dic[@"rows"];
    for (int i = 0; i< array.count; i++) {
        CellModel* model = [[CellModel alloc] init];
        [model parse:array[i]];
        [self.rows addObject:model];
    }
}

@end

@implementation CellModel

-(void)parse:(NSDictionary*)dic{
    self.title = [self judgeNull:dic[@"title"]];
    self.imageHref = [self judgeNull:dic[@"imageHref"]];
    self.des = [self judgeNull:dic[@"description"]];
}

-(id)judgeNull:(id)data{
    return (!data || [data isEqual:[NSNull null]] )?@"":data;
}

@end
