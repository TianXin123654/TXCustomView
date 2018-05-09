//
//  TXThreeController.m
//  TXCustomViewDemo
//
//  Created by 新华龙mac on 2018/2/27.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import "TXThreeController.h"
#import "TXCustomView.h"
#import "UIImageView+WebCache.h"

#import "TXCustomTopView.h"
#import "TXCustomBottomView.h"


@interface TXThreeController ()<
UITableViewDelegate,
UITableViewDataSource,
TXCustomViewDataSource,
TXCustomViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TXCustomView *customView;

@property (nonatomic, strong) NSMutableArray *arrayData;//假数据数组
@property (nonatomic, strong) NSMutableArray *arrayDataL;//假数据数组


@end

@implementation TXThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor grayColor];
    return view;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    NSArray *arrayTemp = self.arrayData[indexPath.section];
    [imageView sd_setImageWithURL:[NSURL URLWithString:arrayTemp[indexPath.row]] placeholderImage:[UIImage imageNamed:@"news_placehold_double"]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    imageView.clipsToBounds = YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [cell addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.frame = CGRectMake(0, 120, SCREEN_WIDTH, 30);
    label.textColor = [UIColor grayColor];
    label.text = self.arrayDataL[indexPath.section][0];
    [cell addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arrayImage =self.arrayData[indexPath.section];
    NSArray *arrayDescription = self.arrayDataL[indexPath.section];
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<arrayImage.count; i++) {
        TXCustomPhoto *customImage = [[TXCustomPhoto alloc]init];
        customImage.minUrl =[NSURL URLWithString:arrayImage[i]];
        customImage.placeHolder = [UIImage imageNamed:@"news_placehold_double"];
        customImage.photoDescription = arrayDescription[i];
        [arrayTemp addObject:customImage];
    }
    //2. 从cell上获取 作为动画开始的Super UIImageView
    UITableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];
    for (id view in nextCell.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *superImageView = (UIImageView *)view;
            [self.customView showImageWithSuperView:superImageView
                                     TXCustomImages:arrayTemp];
        }
    }
}

#pragma mark - TXCustomViewDataSource
- (UIView *)customTopView{
    TXCustomTopView *vc = [[TXCustomTopView alloc]init];
    vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    //关闭预览按钮
    [vc setBlock:^{
        [self.customView hideImage];
    }];
    return vc;
}

- (UIView *)customBottomView{
    TXCustomBottomView *vc = [[[NSBundle mainBundle]loadNibNamed:@"TXCustomBottomView" owner:self options:nil] lastObject];
    vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    return vc;
}

//- (UIView *)customLongPressView
//{
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor orangeColor];
//    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 190);
//    UILabel *label = [[UILabel alloc]init];
//    label.frame = view.bounds;
//    label.text = @"自定义拓展view";
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:label];
//    return view;
//}

#pragma mark - TXCustomViewDelegate
//滑动到第几张
- (void)customViewSlideAtIndex:(NSInteger )index{
    NSLog(@"当前展示的第%ld张图片",(long)index);
}

//开始预览
- (void)customViewBeginPreview{
    NSLog(@"开始进入图片预览");
}

//结束预览
- (void)customViewFinishPreview{
    NSLog(@"结束图片预览");
}

//提供给外界以做调整
- (void)customViewDescriptionView:(TXCustomDescriptionView *)descriptionView{
    descriptionView.descriptionLableColor = [UIColor whiteColor];
    descriptionView.descriptionLableFont = [UIFont systemFontOfSize:16];
    descriptionView.descriptionViewColor = [UIColor blackColor];
    descriptionView.descriptionLableAlpha = 1;
}
#pragma mark - Lazy
- (TXCustomView *)customView
{
    if (!_customView) {
        _customView = [[TXCustomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _customView.dataSource = self;
        _customView.delegate = self;
        _customView.longPressDuration = 1;
        _customView.customViewContentType = CustomViewContentTypeDescription;
    }
    return _customView;
}

- (NSMutableArray *)arrayDataL{
    if (!_arrayDataL) {
        _arrayDataL = [[NSMutableArray array]init];
        NSArray *array1 = @[
                            @"你好吗？陌生人？(提供部分属性拓展)",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在",
                            @"报道称，美印之间的贸易摩擦正在使两国目前密切的政治关系蒙上阴影。美国国务院发言人表示，印度必须减少阻碍美印经济关系的贸易壁垒。",
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中",
                            @"又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。”",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在印度提高数十种产品的关税，欲帮助本国制造的产品避免贸易分歧后，美国企业和外交人士都在向印度施压，要求其降低关税。",
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中，又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品。印度方面表示，此举旨在为本国工业提供发展机会，这是是更宏大的计划的一部分。（海外网 杨佳）",
                            ];
        
        NSArray *array2 = @[
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在印度提高数十种产品的关税，欲帮助本国制造的产品避免贸易分歧后，美国企业和外交人士都在向印度施压，要求其降低关税。",
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中，又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品。印度方面表示，此举旨在为本国工业提供发展机会，这是是更宏大的计划的一部分。（海外网 杨佳）",
                            ];
        NSArray *array3 = @[
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。”",

                            
                            ];
        NSArray *array4 = @[
                            @"你好吗？陌生人？",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在",
                            @"报道称，美印之间的贸易摩擦正在使两国目前密切的政治关系蒙上阴影。美国国务院发言人表示，印度必须减少阻碍美印经济关系的贸易壁垒。",
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中",
                            ];
        
        NSArray *array5 = @[
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中",
                            @"又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。”",
                            ];
        NSArray *array6 = @[
                            @"2017年12月，印度宣布对进口手机和电视机等电子产品征收更高的进口税。而且，在2月做出的预算中，又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品。印度方面表示，此举旨在为本国工业提供发展机会，这是是更宏大的计划的一部分。（海外网 杨佳）",

                            ];
        
        NSArray *array7 = @[
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在",
                            @"报道称，美印之间的贸易摩擦正在使两国目前密切的政治关系蒙上阴影。美国国务院发言人表示，印度必须减少阻碍美印经济关系的贸易壁垒。",
                            ];
        
        NSArray *array8 = @[
                            @"又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。”",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在印度提高数十种产品的关税，欲帮助本国制造的产品避免贸易分歧后，美国企业和外交人士都在向印度施压，要求其降低关税。",
                            ];
        
        NSArray *array9 = @[
                            @"又增加40项需缴纳关税的产品清单，包括太阳镜、果汁和汽车零部件等各种商品",
                            @"特朗普要求印度调整对哈雷-戴维森（Harley-Davidson）摩托车公司所征收的关税，他表示，“前几天，印度总理打电话给我说他已经将进口关税降低到50%，我说好，但是直到现在美国还是一无所获”，“他们自认为帮了我们一个忙，但实际上并没有。”",
                            @"这已经是特朗普一个月内第二次提出印度对摩托车进口关税高的问题。据英国路透社2月23日报道，在印度提高数十种产品的关税，欲帮助本国制造的产品避免贸易分歧后，美国企业和外交人士都在向印度施压，要求其降低关税。",
                            ];
        
        _arrayDataL = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8, array9,nil];
    }
    return _arrayDataL;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
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
      
        _arrayData = [[NSMutableArray alloc]initWithObjects:array1,array2,array3,array4,array5,array6,array7,array8, array9,nil];
        
    }
    return _arrayData;
}

@end
