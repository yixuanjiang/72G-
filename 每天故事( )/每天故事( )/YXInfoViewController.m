//
//  YXInfoViewController.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/28.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXInfoViewController.h"
#import "PushViewController.h"

@interface YXInfoViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *mainView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation YXInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *mainView = [UITableView new];
    _mainView = mainView;
    mainView.frame = self.view.bounds;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.rowHeight = 60;
    //    [mainView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:mainView];
}

-(NSMutableArray *)data{
    if (!_data) {
        _data = @[].mutableCopy;
        for (int i = 1; i < 13; i ++) {
            [_data addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        }
        [_data addObjectsFromArray:_data];
        [_data addObjectsFromArray:_data];
    }
    return _data;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.hidden = NO;
    cell.imageView.image = [UIImage imageNamed:_data[indexPath.row]];
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PushViewController *pushVC = [PushViewController new];
    self.navigationController.delegate = pushVC;
    [self.navigationController pushViewController:pushVC animated:YES];
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
