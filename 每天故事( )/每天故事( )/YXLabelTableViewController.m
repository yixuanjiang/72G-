//
//  YXLabelTableViewController.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXLabelTableViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YXLabelModel.h"
#import "YXRecomLabelCellTableViewCell.h"
#import "YXLabelFrameModel.h"
#import "MJRefresh.h"
#import <AVFoundation/AVFoundation.h>


@interface YXLabelTableViewController ()

@property (nonatomic,strong) NSArray *labelModelArr;
/***   frame模型   */
@property (nonatomic,strong) NSMutableArray *labelFrameModelArr;
/***   刷新所需参数   */
@property (nonatomic,copy) NSString *maxtime;
/***   最新数据时间   */
@property (nonatomic,copy) NSString *NewTime;

@end

@implementation YXLabelTableViewController
static NSString *labelId = @"labelCell";


- (NSMutableArray *)labelFrameModelArr
{
    if (!_labelFrameModelArr) {
        _labelFrameModelArr = [NSMutableArray array];
    }
    return _labelFrameModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //请求URl
    NSString *str = @"http://api.budejie.com/api/api_open.php";
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.NewTime = responseObject[@"list"][0][@"created_at"];
        self.labelModelArr = [YXLabelModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        for (YXLabelModel *labelModel in self.labelModelArr) {
            YXLabelFrameModel *labelFrameModel = [[YXLabelFrameModel alloc] init];
            labelFrameModel.model = labelModel;
            [self.labelFrameModelArr addObject:labelFrameModel];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXRecomLabelCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:labelId];
    
    /***   下拉刷新   */
    [self.tableView addHeaderWithTarget:self action:@selector(headerFresh)];
    /***   上拉加载更多   */
    [self.tableView addFooterWithTarget:self action:@selector(footerFresh)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.labelFrameModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXLabelFrameModel *LabelFramemodel = self.labelFrameModelArr[indexPath.row];
    
    YXRecomLabelCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:labelId];
    cell.frameModel = LabelFramemodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXLabelFrameModel *LabelFramemodel = self.labelFrameModelArr[indexPath.row];
    
    CGSize textSize = [LabelFramemodel.model.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    return (textSize.height + 130);
    
}


/***   下拉刷新   */
- (void)headerFresh
{
    //请求URl
    NSString *str = @"http://api.budejie.com/api/api_open.php";
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.NewTime isEqualToString:responseObject[@"list"][0][@"created_at"]]) {
            //提示是最新数据
            [self newData];
        }
    
        self.NewTime = responseObject[@"list"][0][@"created_at"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.labelModelArr = [YXLabelModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //移除数组
        [self.labelFrameModelArr removeAllObjects];
        for (YXLabelModel *labelModel in self.labelModelArr) {
            YXLabelFrameModel *labelFrameModel = [[YXLabelFrameModel alloc] init];
            labelFrameModel.model = labelModel;
            [self.labelFrameModelArr addObject:labelFrameModel];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

/***   上拉刷新   */
- (void)footerFresh
{
    //请求URl
    NSString *str = @"http://api.budejie.com/api/api_open.php";
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"maxtime"] = self.maxtime;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.labelModelArr = [YXLabelModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        for (YXLabelModel *labelModel in self.labelModelArr) {
            YXLabelFrameModel *labelFrameModel = [[YXLabelFrameModel alloc] init];
            labelFrameModel.model = labelModel;
            [self.labelFrameModelArr addObject:labelFrameModel];
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

/***   提示更新为最新数据   */
- (void)newData
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 25)];
    label.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    label.textColor = [UIColor colorWithRed:65/255.0 green:156/255.0 blue:133/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"已是最新数据";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXLabelFrameModel *LabelFramemodel = self.labelFrameModelArr[indexPath.row];
    
    /***   语言   */
   AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:LabelFramemodel.model.text];
    [av speakUtterance:utterance];
                                    
    return indexPath;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
