//
//  SmallModel.h
//  TestSmall
//
//  Created by slg on 2018/3/20.
//  Copyright © 2018年 slg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSMutableArray* rows;
-(void)parse:(NSDictionary*)dic;
@end

@interface CellModel : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* imageHref;
@property (nonatomic, strong) NSString* des;
@property (nonatomic, assign) float height;

-(void)parse:(NSDictionary*)dic;
@end
