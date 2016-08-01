//
//  YXMineInfoTableVC.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/21.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXMineInfoTableVC.h"
#import "InfoLabelModel.h"
#import "InfoLabelGroup.h"
#import "YXUpDateNameVC.h"
#import "YXUpDateNameVC.h"
#import "YXMineInfoCell.h"
#import "YXMineLabelCell.h"
#import "YXSexTableVC.h"
#import "YXGeXingNameVC.h"


@interface YXMineInfoTableVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,YXUpDateNameVCDelegate,YXSexTableVCDelegate>

@property (nonatomic,strong) NSMutableArray *modelArray;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;

@end

@implementation YXMineInfoTableVC

#pragma mark - 懒加载模型数组
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
    
    //初始化视图选择控制器
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.allowsEditing = YES;
    self.imagePickerController.delegate = self;
    
    //创建数据模型
    InfoLabelModel *model1 = [[InfoLabelModel alloc] init];
    model1.title = @"头像";
    InfoLabelModel *model2 = [[InfoLabelModel alloc] init];
    model2.title = @"昵称";
    InfoLabelModel *model3 = [[InfoLabelModel alloc] init];
    model3.title = @"性别";
    InfoLabelModel *model4 = [[InfoLabelModel alloc] init];
    model4.title = @"个性签名";
    InfoLabelGroup *group1 = [[InfoLabelGroup alloc] init];
    group1.infoModels = @[model1,model2,model3,model4];
    [self.modelArray addObject:group1];
    
    InfoLabelModel *model5 = [[InfoLabelModel alloc] init];
    model5.title = @"绑定手机号";
    InfoLabelModel *model6 = [[InfoLabelModel alloc] init];
    model6.title = @"绑定邮箱";
    InfoLabelGroup *group2 = [[InfoLabelGroup alloc] init];
    group2.infoModels = @[model5,model6];
    [self.modelArray addObject:group2];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.modelArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    InfoLabelGroup *group = self.modelArray[section];
    return group.infoModels.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoLabelGroup *group = self.modelArray[indexPath.section];
    InfoLabelModel *model = group.infoModels[indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *ID = @"cell";
            YXMineInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (cell == nil) {
                cell = [[YXMineInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            }
            cell.model = model;
            
            return cell;
        }
    }
    
    static NSString *ID1 = @"label";
    YXMineLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
    if (cell == nil) {
        cell = [[YXMineLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
    }
    cell.model = model;
    
    return cell;
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 3) {
            return 80;
        }else
        {
            return 44;
        }
    }else
    {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - 点击cell
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    InfoLabelGroup *group = self.modelArray[indexPath.section];
    InfoLabelModel *model = group.infoModels[indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"拍照");
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机设备不可用，或已损坏" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alertController addAction:alertAction];
                    
                    [self.navigationController presentViewController:alertController animated:YES completion:^{
                        
                    }];
                }else
                {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:self.imagePickerController animated:YES completion:nil];
        

                }
                
            }];
            [alertController addAction:action];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:self.imagePickerController animated:YES completion:nil];
                
            }];
            [alertController addAction:action1];
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:alertAction];
            
            [self.navigationController presentViewController:alertController animated:YES completion:^{
                
            }];
        }else if (indexPath.row == 1)
        {
            YXUpDateNameVC *updateNameVC = [[YXUpDateNameVC alloc] init];
            updateNameVC.delagate = self;
            [self.navigationController pushViewController:updateNameVC animated:YES];
        }else if (indexPath.row == 2)
        {
            YXSexTableVC *sexTableVC = [[YXSexTableVC alloc] init];
            sexTableVC.selectedSex = model.label;
            sexTableVC.sexDelegate = self;
            [self.navigationController pushViewController:sexTableVC animated:YES];
        }else if (indexPath.row == 3)
        {
            YXGeXingNameVC *geXingNameVC = [[YXGeXingNameVC alloc] init];
            [self.navigationController pushViewController:geXingNameVC animated:YES];
        }
    }
    
    return indexPath;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImageView *icon = cell.subviews[1];
    [icon setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - YXUpDateNameVCDelegate
- (void)YXUpDateNameVC:(YXUpDateNameVC *)upDateName passName:(NSString *)name
{
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    YXMineLabelCell *cell = [self.tableView cellForRowAtIndexPath:index];
    cell.model.label = name;
    [self.tableView reloadData];
}


#pragma mark - YXSexTableVCDelegate
- (void)YXSexTableVC:(YXSexTableVC *)sexTableVC passSex:(NSString *)sex
{
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    YXMineLabelCell *cell = [self.tableView cellForRowAtIndexPath:index];
    cell.model.label = sex;
    [self.tableView reloadData];
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
