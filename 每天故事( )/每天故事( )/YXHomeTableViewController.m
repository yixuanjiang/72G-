//
//  YXHomeTableViewController.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/18.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXHomeTableViewController.h"
#import "AFNetworking.h"
#import "YXReconmmedModel.h"
#import "MJExtension.h"
#import "YXRecommendCell.h"
#import "MJRefresh.h"
#import "YXMySql.h"
#import "SVProgressHUD.h"


@interface YXHomeTableViewController ()

@property (nonatomic,strong) NSMutableArray *reconmmendModelArr;

@property (nonatomic,copy) NSString *maxtime;

/***   最新数据时间   */
@property (nonatomic,copy) NSString *NewTime;

@end

@implementation YXHomeTableViewController
static NSString *recommendId = @"recommendCell";

/***   懒加载模型数组   */
- (NSMutableArray *)reconmmendModelArr
{
    if (!_reconmmendModelArr) {
        _reconmmendModelArr = [NSMutableArray array];
    }
    return _reconmmendModelArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //请求URl
    NSString *str = @"http://api.budejie.com/api/api_open.php";
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"10";
    
    if ([YXMySql picCachesWithMaxid:nil].count) {
        //从沙盒取数据
        NSDictionary *picDic = [YXMySql picCachesWithMaxid:nil];
        self.maxtime = picDic[@"maxid"];
        
        NSArray *array = [YXReconmmedModel objectArrayWithKeyValuesArray:picDic[@"picArray"]];
        self.reconmmendModelArr = [NSMutableArray arrayWithArray:array];
    }else
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 5;
        [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            //缓存到沙盒
            [YXMySql savePicCaches:responseObject[@"list"] withMaxId:responseObject[@"info"][@"maxtime"]];
            
            self.maxtime = responseObject[@"info"][@"maxtime"];
            self.NewTime = responseObject[@"list"][0][@"created_at"];
            
            NSArray *array = [YXReconmmedModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
            self.reconmmendModelArr = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
    }
    
    
    //注册一个cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YXRecommendCell class]) bundle:nil] forCellReuseIdentifier:recommendId];
    
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

    return self.reconmmendModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXReconmmedModel *model = self.reconmmendModelArr[indexPath.row];
    
    
    YXRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendId];
    
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXReconmmedModel *model = self.reconmmendModelArr[indexPath.row];
    
    return model.cellHeight;
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
    params[@"type"] = @"10";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    
    [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.NewTime isEqualToString:responseObject[@"list"][0][@"created_at"]]) {
            //提示是最新数据
            [self newData];
        }
        NSLog(@"%@",responseObject);
        if (![self.maxtime isEqualToString:responseObject[@"info"][@"maxtime"]]) {
            //缓存到沙盒
            [YXMySql savePicCaches:responseObject[@"list"] withMaxId:responseObject[@"info"][@"maxtime"]];
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.NewTime = responseObject[@"list"][0][@"created_at"];
        
        NSArray *array = [YXReconmmedModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.reconmmendModelArr = [NSMutableArray arrayWithArray:array];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
        [self.tableView headerEndRefreshing];
    }];
    
}

/***   上拉加载更多   */
- (void)footerFresh
{
    //请求URl
    NSString *str = @"http://api.budejie.com/api/api_open.php";
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"10";
    params[@"maxtime"] = self.maxtime;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:str parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *array = [YXReconmmedModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.reconmmendModelArr addObjectsFromArray:array];

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
