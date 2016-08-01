//
//  MeTableVC.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "MeTableVC.h"
#import "MineCellModel.h"
#import "MineGroup.h"
#import "MineArrowModel.h"
#import "MineMoonModel.h"
#import "YXMineInfoTableVC.h"
#import "DKNightVersion.h"

@interface MeTableVC ()

@property (nonatomic,strong) NSMutableArray *modelsArray;

@end

@implementation MeTableVC

#pragma mark - 懒加载models
- (NSMutableArray *)modelsArray
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加右侧的rightBarButtonItem
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_web"] forState:UIControlStateNormal];
    CGSize size = button.currentBackgroundImage.size;
    button.frame = CGRectMake(0, 0, size.width, size.height);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //创建模型
    MineCellModel *model0 = [MineArrowModel modelWithIcon:@"img_68" text:@"轩"];
    model0.context = @"这个人很神秘，什么也没有留下";
    MineGroup *group0 = [[MineGroup alloc] init];
    group0.models = @[model0];
    [self.modelsArray addObject:group0];
    
    MineCellModel *model1 = [MineArrowModel modelWithIcon:@"icon_my_book" text:@"作品"];
    MineCellModel *model2 = [MineArrowModel modelWithIcon:@"icon_my_star" text:@"收藏"];
    MineCellModel *model3 = [MineArrowModel modelWithIcon:@"icon_my_praise" text:@"赞过"];
    MineCellModel *model4 = [MineArrowModel modelWithIcon:@"icon_my_local" text:@"离线"];
    MineGroup *group1 = [[MineGroup alloc] init];
    group1.models = @[model1,model2,model3,model4];
    [self.modelsArray addObject:group1];
    
    MineCellModel *model5 = [MineArrowModel modelWithIcon:@"icon_my_homepage" text:@"我的主页"];
    MineGroup *group2 = [[MineGroup alloc] init];
    group2.models = @[model5];
    [self.modelsArray addObject:group2];
    
    MineCellModel *model6 = [MineMoonModel modelWithIcon:@"icon_my_night" text:@"夜间模式"];
    MineCellModel *model7 = [MineArrowModel modelWithIcon:@"icon_my_settings" text:@"设置"];
    MineGroup *group3 = [[MineGroup alloc] init];
    group3.models = @[model6,model7];
    [self.modelsArray addObject:group3];
    
    
    /***   改变背景颜色   */
    self.tableView.dk_backgroundColorPicker =  DKColorWithRGB(0, 0x313131);
    self.tableView.dk_separatorColorPicker = DKColorWithRGB(0, 0x313131);
    
   
    
}

- (void)buttonClick:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网页版请登录www.dudiangushi.com" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
                                  
    [self.navigationController presentViewController:alertController animated:YES completion:^{
    
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.modelsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //获取组
    MineGroup *group = self.modelsArray[section];
    return group.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型
    MineGroup *group = self.modelsArray[indexPath.section];
    MineCellModel *model = group.models[indexPath.row];
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.layer.cornerRadius = 34;
        cell.imageView.layer.masksToBounds = YES;
    }

    //设置数据
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.textLabel.text = model.text;
    cell.detailTextLabel.text = model.context;
    
    /***   夜间模式   */
    cell.textLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    cell.detailTextLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    cell.dk_backgroundColorPicker =  DKColorWithRGB(0xffffff, 0x343434);
    
    //根据cell的种类设置
    if ([model isKindOfClass:[MineArrowModel class]]) {
       UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nva_goto"]];
        cell.accessoryView = imageV;
    }else if ([model isKindOfClass:[MineMoonModel class]])
    {
        UISwitch *changeColor = [[UISwitch alloc] init];
        [changeColor addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = changeColor;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 设置分区Header高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }else
    {
        return 10;
    }
}

#pragma mark - 设置分区Footer高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }else
    {
        return 10;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat leftMargin = 20;
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
        UIButton *writeButton = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, 0, self.tableView.frame.size.width - 2 * leftMargin, 40)];
        [writeButton setTitle:@"写个故事" forState:UIControlStateNormal];
        [writeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [writeButton setBackgroundImage:[UIImage imageNamed:@"btn_write"] forState:UIControlStateNormal];
        [view addSubview:writeButton];
        
        return view;
    }else
    {
        return nil;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        CGFloat careLabelW = 50;
        CGFloat careLabelH = 20;
        CGFloat careLabelX = (self.tableView.frame.size.width - 2 * careLabelW) / 3;
        //创建关注label
        UILabel *careLabel = [[UILabel alloc] initWithFrame:CGRectMake(careLabelX, careLabelH, careLabelW, careLabelH)];
        careLabel.textColor = [UIColor grayColor];
        careLabel.textAlignment = NSTextAlignmentCenter;
        careLabel.text = @"关注";
        //创建粉丝label
        UILabel *funLabel = [[UILabel alloc] initWithFrame:CGRectMake(careLabelX + (careLabelW + careLabelX), careLabelH, careLabelW, careLabelH)];
        funLabel.textColor = [UIColor grayColor];
        funLabel.textAlignment = NSTextAlignmentCenter;
        funLabel.text = @"粉丝";
        
        UIView *bgView = [[UIView alloc] init];
        //bgView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
       
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
        //添加关注label
        [view addSubview:careLabel];
        //添加关注label
        [view addSubview:funLabel];
        [bgView addSubview:view];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width / 2, 0, 1, 40)];
        lineView.alpha = 0.3;
        lineView.backgroundColor = [UIColor grayColor];
        [bgView addSubview:lineView];
        
        view.dk_backgroundColorPicker =  DKColorWithRGB(0xffffff, 0x343434);
        return bgView;
    }else
    {
       return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}

#pragma mark - 手势点击实现方法 
- (void)click:(UITapGestureRecognizer *)sender
{
    CGPoint tapPoint =[sender locationInView:sender.view];
    if (tapPoint.x < self.tableView.frame.size.width / 2) {
        NSLog(@"关注");
    }else
    {
        NSLog(@"粉丝");
    }
}

#pragma mark - 点击cell
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取模型
    MineGroup *group = self.modelsArray[indexPath.section];
    MineCellModel *model = group.models[indexPath.row];
    if (indexPath.section == 0) {
        YXMineInfoTableVC *infoTableVC = [[YXMineInfoTableVC alloc] initWithStyle:UITableViewStyleGrouped];
        infoTableVC.navigationItem.title = @"个人信息";
        [self.navigationController pushViewController:infoTableVC animated:YES];
    }else{
        
    }
    
    
    
    return indexPath;
}

- (void)changeColor
{
    DKNightVersionManager *manager = [DKNightVersionManager sharedNightVersionManager];
    
    if (manager.themeVersion == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
    NSLog(@"111");
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
