//
//  ShowListViewController.m
//  TestSmall
//
//  Created by slg on 2018/3/20.
//  Copyright © 2018年 slg. All rights reserved.
//

#import "ShowListViewController.h"
#import <AFNetworking.h>
#import "SmallModel.h"
#import <Masonry.h>
#import "SmallTableViewCell.h"

@interface ShowListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView* tableView;

@property (nonatomic, strong) SmallModel* model;

@property (nonatomic, strong) NSMutableDictionary* dic;

@end


@implementation ShowListViewController


-(NSMutableDictionary*)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

-(SmallModel*)model{
    if (!_model) {
        _model = [[SmallModel alloc] init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self loadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellModel* model = self.model.rows[indexPath.row];
    return model.height;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* string = @"cell";
    SmallTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
       cell = [[SmallTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CellModel* model = self.model.rows[indexPath.row];
    [cell addModel:model];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[AFHTTPSessionManager manager] GET:@"http://thoughtworks-ios.herokuapp.com/facts.json" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"suc");
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSDictionary* dic = responseObject;
                [self.model.rows removeAllObjects];
                [self.model parse:dic];
                for (int i = 0; i < self.model.rows.count; i++) {
                    CellModel* model = self.model.rows[i];
                    if (model.des.length == 0 && model.title.length == 0) {
                        model.height = 0;
                        continue;
                    }
                    CGFloat width = SCREENWIDTH-30;
                    if (model.imageHref.length > 0) {
                        width = width - 70;
                    }
                    CGRect rect = [model.des boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                            NSFontAttributeName:[UIFont systemFontOfSize:13]
                                                                                                                                                            }context:nil];
                    //判断图片存在时候的尺寸和des的大小
                    CGFloat height =  MAX(rect.size.height, 80) + 65;
                    model.height = height;

                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.title = self.model.title;
                    [self.tableView reloadData];
                });
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"fail");
        }];
    });
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
