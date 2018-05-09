//
//  TXViewController.m
//  TXCustomViewDemo
//
//  Created by 新华龙mac on 2018/1/10.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import "TXViewController.h"
#import "TXFistController.h"
#import "TXSecondController.h"

#import "TXThreeController.h"
@interface TXViewController ()
@property (nonatomic, strong)NSMutableArray *arrayData;

@end

@implementation TXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)firstButtonAtcion:(UIButton *)sender {
    TXFistController *fistVc = [[TXFistController alloc]init];
    [self.navigationController pushViewController:fistVc animated:YES];
    
}

- (IBAction)secondButtonAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"如果使用自定义模式请先使用TXCustomTools 计算大小" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *s = [UIAlertAction actionWithTitle:@"知道了"
                                                style:UIAlertActionStyleCancel
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  TXSecondController *secondVc = [[TXSecondController alloc]init];
                                                  [self.navigationController pushViewController:secondVc animated:YES];
                                              }];
    [alert addAction:s];
    [self presentViewController:alert
                       animated:true
                     completion:nil];
    
}

- (IBAction)showImageArray:(UIButton *)sender {
    TXThreeController *vc = [[TXThreeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
