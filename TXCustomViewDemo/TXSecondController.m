//
//  TXUserInfoViewController.m
//  彩票生成器
//
//  Created by 新华龙mac on 17/3/6.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXSecondController.h"
#import "TXCustomView.h"
@interface TXSecondController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSMutableArray *arrayDataModel;
@property (nonatomic, strong) TXCustomSizeSettings *sets;

@end

@implementation TXSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self configData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configData
{
    //拓展自定义设置
    self.sets = [[TXCustomSizeSettings alloc]init];
    self.sets.imageInterval = 5.0;
    self.sets.throwNumber = 3;
    self.sets.defaultImageSize = CGSizeMake(100, 100);
    self.sets.onlyOneImageSize = CGSizeMake(300, 300);
    self.sets.onlyTwoImageSize = CGSizeMake(80, 80);
    self.sets.onlyThreeImageSize = CGSizeMake(20, 50);
    self.sets.frontRowImageSize = CGSizeMake(20, 80);
    
    for (int j = 0; j<self.arrayData.count; j++) {
        NSArray *array =self.arrayData[j];
        NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<array.count; i++) {
            TXCustomPhoto *customImage = [[TXCustomPhoto alloc]init];
            customImage.minUrl =[NSURL URLWithString:array[i]];
            customImage.photoDescription = @"22222222222222";
            [arrayTemp addObject:customImage];
        }
        [self.arrayDataModel addObject:arrayTemp];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayData.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array =self.arrayData[indexPath.section];
    CGSize size = [TXCustomTools getCustomViewSizeWithImageCount:array.count withSetting: self.sets];
    NSLog(@"size== %@",NSStringFromCGSize(size));
    return size.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor orangeColor];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *array = self.arrayDataModel[indexPath.section];
    CGSize size = [TXCustomTools getCustomViewSizeWithImageCount:array.count withSetting:self.sets];
    TXCustomView *gsgs = [[TXCustomView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    gsgs.backgroundColor = [UIColor  redColor];
    [gsgs setCustomViewSizeWithImageArray:array withSetting:self.sets];
    [cell addSubview:gsgs];
    return cell;
}

#pragma mark - Lazy

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)arrayDataModel
{
    if (!_arrayDataModel) {
        _arrayDataModel = [[NSMutableArray alloc]init];
    }
    return _arrayDataModel;
}

-(NSMutableArray *)arrayData
{
    if (!_arrayData) {
        NSArray *array1 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455362&di=2f8e54f1ea15ceed2a4a286c0804f8df&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172252_kTASa.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729472725&di=d440c3412941985e147043239fb2d6c0&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3610453425%2C2298509516%26fm%3D214%26gp%3D0.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=8ca3320e859760d155dd68bc5c38a94f&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172413_rEaJJ.thumb.700_0.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=5cce8c94913836c871b51bd3623c8a51&imgtype=0&src=http%3A%2F%2Ff8.topitme.com%2F8%2Fae%2F0d%2F113073231011c0dae8o.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=469ed6a4b3d2d7606214434f30f45b96&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172443_idS2a.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455360&di=91d6409dc9dd0dface4323b4ea4ea6f5&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F72%2Fd%2F188.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=39b3aa634e2e79cb61863263296d80d3&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130521%2F12803647_204959557163_2.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577862&di=05518bc517a44edf0a74588f09f89eb3&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F30%2F20140630104259_TvE4K.thumb.700_0.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=cde4a1929fe8e8ea024de2dd5284cbd6&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F53%2F19%2F87758PICdZI_1024.jpg"
                            ];
        
        NSArray *array2 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=469ed6a4b3d2d7606214434f30f45b96&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172443_idS2a.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455360&di=91d6409dc9dd0dface4323b4ea4ea6f5&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F72%2Fd%2F188.jpg",
                            ];
        NSArray *array3 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=5cce8c94913836c871b51bd3623c8a51&imgtype=0&src=http%3A%2F%2Ff8.topitme.com%2F8%2Fae%2F0d%2F113073231011c0dae8o.jpg",
                            
                            ];
        NSArray *array4 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=469ed6a4b3d2d7606214434f30f45b96&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172443_idS2a.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455360&di=91d6409dc9dd0dface4323b4ea4ea6f5&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F72%2Fd%2F188.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=39b3aa634e2e79cb61863263296d80d3&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130521%2F12803647_204959557163_2.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577862&di=05518bc517a44edf0a74588f09f89eb3&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F30%2F20140630104259_TvE4K.thumb.700_0.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=cde4a1929fe8e8ea024de2dd5284cbd6&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F53%2F19%2F87758PICdZI_1024.jpg"
                            ];
        
        NSArray *array5 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729472725&di=d440c3412941985e147043239fb2d6c0&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3610453425%2C2298509516%26fm%3D214%26gp%3D0.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=39b3aa634e2e79cb61863263296d80d3&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130521%2F12803647_204959557163_2.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577862&di=05518bc517a44edf0a74588f09f89eb3&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F30%2F20140630104259_TvE4K.thumb.700_0.jpeg",
                            ];
        NSArray *array6 = @[
                            
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729472725&di=d440c3412941985e147043239fb2d6c0&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3610453425%2C2298509516%26fm%3D214%26gp%3D0.jpg",
                            ];
        
        NSArray *array7 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729472725&di=d440c3412941985e147043239fb2d6c0&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3610453425%2C2298509516%26fm%3D214%26gp%3D0.jpg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=8ca3320e859760d155dd68bc5c38a94f&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172413_rEaJJ.thumb.700_0.jpeg",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=5cce8c94913836c871b51bd3623c8a51&imgtype=0&src=http%3A%2F%2Ff8.topitme.com%2F8%2Fae%2F0d%2F113073231011c0dae8o.jpg",
                            ];
        
        NSArray *array8 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577862&di=05518bc517a44edf0a74588f09f89eb3&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F30%2F20140630104259_TvE4K.thumb.700_0.jpeg",
                            @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=665316743,3428873680&fm=27&gp=0.jpg",
                            ];
        
        NSArray *array9 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824764&di=68155d697802042f0dfdf79e437a4af5&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201408%2F20%2F20140820155136_QkyW8.thumb.700_0.png",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824765&di=8630a7613e11a6f7d9840160c4c93639&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F89%2F87%2F55a73a600f7b3_1024.jpg",
                            @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=665316743,3428873680&fm=27&gp=0.jpg",
                            ];
        NSArray *array10 = @[
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824764&di=68155d697802042f0dfdf79e437a4af5&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201408%2F20%2F20140820155136_QkyW8.thumb.700_0.png",
                             
                             ];
        NSArray *array11 = @[
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455360&di=91d6409dc9dd0dface4323b4ea4ea6f5&imgtype=0&src=http%3A%2F%2Fimg1.3lian.com%2F2015%2Fa1%2F72%2Fd%2F188.jpg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577863&di=39b3aa634e2e79cb61863263296d80d3&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130521%2F12803647_204959557163_2.jpg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729577862&di=05518bc517a44edf0a74588f09f89eb3&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201406%2F30%2F20140630104259_TvE4K.thumb.700_0.jpeg",
                             ];
        
        NSArray *array12 = @[
                             
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824765&di=8630a7613e11a6f7d9840160c4c93639&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F89%2F87%2F55a73a600f7b3_1024.jpg",
                             @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=665316743,3428873680&fm=27&gp=0.jpg",
                             ];
        NSArray *array13 = @[
                             
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824764&di=68155d697802042f0dfdf79e437a4af5&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201408%2F20%2F20140820155136_QkyW8.thumb.700_0.png",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824765&di=8630a7613e11a6f7d9840160c4c93639&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F89%2F87%2F55a73a600f7b3_1024.jpg",
                             @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=665316743,3428873680&fm=27&gp=0.jpg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729824768&di=c1da402d156976405a8d5adf79c61484&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172416_SdBPa.jpeg"
                             ];
        
        NSArray *array14 = @[
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729472725&di=d440c3412941985e147043239fb2d6c0&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D3610453425%2C2298509516%26fm%3D214%26gp%3D0.jpg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=8ca3320e859760d155dd68bc5c38a94f&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201312%2F05%2F20131205172413_rEaJJ.thumb.700_0.jpeg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1519729455361&di=5cce8c94913836c871b51bd3623c8a51&imgtype=0&src=http%3A%2F%2Ff8.topitme.com%2F8%2Fae%2F0d%2F113073231011c0dae8o.jpg",
                             ];
        _arrayData = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8, array9,array10,array11,array12,array13,array14,nil];
        
    }
    return _arrayData;
    
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
