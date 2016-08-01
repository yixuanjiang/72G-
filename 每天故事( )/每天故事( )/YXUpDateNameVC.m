//
//  YXUpDateNameVC.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXUpDateNameVC.h"

@interface YXUpDateNameVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *upDateName;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation YXUpDateNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    //改变确定按钮的颜色
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.upDateName becomeFirstResponder];
    
    /***   设置代理   */
    self.upDateName.delegate = self;
    
    //监听textField事件
    //创建一个NSNotificationCenter对象。
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)rightButtonClick
{
    NSString *name = self.upDateName.text;
    [self.delagate YXUpDateNameVC:self passName:name];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldChange
{
    NSString *name = self.upDateName.text;
    if (name.length > 8) {
        self.numLabel.text = @"8/8";
    }else
    {
        self.numLabel.text = [NSString stringWithFormat:@"%ld/8",name.length];
    }
}

#pragma  mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.upDateName) {
        if (textField.text.length > 8) return NO;
    }
    return YES;
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
