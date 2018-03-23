//
//  SmallTableViewCell.h
//  TestSmall
//
//  Created by slg on 2018/3/21.
//  Copyright © 2018年 slg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;
@interface SmallTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UIImageView* imgView;

-(void)addModel:(CellModel*)model;
@end
