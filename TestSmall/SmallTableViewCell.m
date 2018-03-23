//
//  SmallTableViewCell.m
//  TestSmall
//
//  Created by slg on 2018/3/21.
//  Copyright © 2018年 slg. All rights reserved.
//

#import "SmallTableViewCell.h"
#import <Masonry.h>
#import "SmallModel.h"

@interface SmallTableViewCell ()

@property (nonatomic, weak) CellModel* model;

@end

@implementation SmallTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19.0f];
        
        self.detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailLabel];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.font = [UIFont systemFontOfSize:13.f];
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.layer.borderWidth = 1.0f;
        self.imgView.clipsToBounds = YES;
        [self.imgView setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        if (self.model.imageHref) {
            make.right.mas_equalTo(self.imgView.mas_left).mas_equalTo(-10);
        }else{
            make.right.mas_equalTo(-15);
        }
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(15);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(80);
    }];
}

-(void)addModel:(CellModel*)model{
    self.model = model;
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.des;
    NSURL* url = [NSURL URLWithString:model.imageHref];
    NSURLRequest* req = [[NSURLRequest alloc] initWithURL:url];
    __weak typeof(self) weakSelf = self;
    [self.imgView setImageWithURLRequest:req placeholderImage:[UIImage imageNamed:@"add"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        NSLog(@"图片加载成功==%@",request.URL);
        [weakSelf.imgView setImage:image];

    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"图片加载失败==%@",request.URL);
        [weakSelf.imgView setImage:[UIImage imageNamed:@"add"]];
    }];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
