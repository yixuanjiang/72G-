//
//  YXSexTableVC.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXSexTableVC.h"
#import "YXSexModel.h"
#import "YXInfoCell.h"

@interface YXSexTableVC ()

@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation YXSexTableVC

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"修改性别";
    
    /***   创建模型   */
    YXSexModel *sexModel1 = [[YXSexModel alloc] init];
    sexModel1.sex = @"男";
    [self.modelArray addObject:sexModel1];
    
    YXSexModel *sexModel2 = [[YXSexModel alloc] init];
    sexModel2.sex = @"女";
    [self.modelArray addObject:sexModel2];
    
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

    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型
    YXSexModel *model = self.modelArray[indexPath.row];
    
    static NSString *ID = @"cell";
    YXInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YXInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.selectedSex isEqualToString:@"男"]) {
        if (indexPath.row == 0) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ganderSelect_nor"]];
        }
    }else if([self.selectedSex isEqualToString:@"女"])
    {
        if (indexPath.row == 1) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ganderSelect_nor"]];
        }
    }
    cell.model = model;
    
    return cell;

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    YXInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ganderSelect_nor"]];
    //获取选中的性别类型
    NSString *sex = cell.model.sex;
    //传到上一个控制器
    if ([self.sexDelegate respondsToSelector:@selector(YXSexTableVC:passSex:)]) {
        [self.sexDelegate YXSexTableVC:self passSex:sex];
    }
    
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:(1-row) inSection:0];
    YXInfoCell *cell1 = [tableView cellForRowAtIndexPath:index];
    cell1.accessoryView = nil;
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
