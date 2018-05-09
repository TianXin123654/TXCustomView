先直接上完成后的效果如下：
![2018-05-09 11_44_04.gif](https://upload-images.jianshu.io/upload_images/9610720-b696a47329973937.gif?imageMogr2/auto-orient/strip)

##### 具体的demo 详见github地址：https://github.com/TianXin123654/TXCustomView


#TXCustomView用法如下
####1.朋友圈快速布局，此方法需要创建TXCustomView的大小，然后传入TXCustomPhoto集合，再设置图片的间距，和数量即可。
```
/**
 快速生成图片框方法(类似九宫格 图片尺寸根据view给定的大小计算)
 
 @param imageArray TXCustomImageArray
 @param interval 图片之间的间距
 @param throwNumber 一排显示的数量
 @param isFit 是否铺满
 */
-(void)setImageArray:(NSArray<TXCustomPhoto *>*)imageArray
    andImageInterval:(NSInteger )interval
      andThrowNumber:(int )throwNumber
   andIsFitImageView:(BOOL)isFit;
```
实现后的效果：![QQ20180509-1332431.png](https://upload-images.jianshu.io/upload_images/9610720-44cc39583f442db0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


####2.根据给定的图片大小计算TXCustomView进行布局，此方法需要创建一个TXCustomSizeSettings类，需求中时常会出现一张图片或两张图片大小不一样。
```
#pragma mark - 下面为拓展自定义属性
/**
 只有一张图片的时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyOneImageSize;//imageSizeForOne

/**
 只有两张图片时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyTwoImageSize;

/**
 只有三张图片时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyThreeImageSize;

/**
 只有一排的时候尺寸
 */
@property (nonatomic, assign)CGSize frontRowImageSize;
```
然后用法
```
/**
 快速生成图片框方法(类似九宫格 图片尺寸根据用户给定的imagesize大小生成)
 
 @param imageArray TXCustomImageArray
 @param sets sets TXCustomSetupSettings自定义拓展设置
 */
-(void)setCustomViewSizeWithImageArray:(NSArray<TXCustomPhoto *>*)imageArray
                           withSetting:(TXCustomSizeSettings *)sets;
```
实现后的效果:
![image.png](https://upload-images.jianshu.io/upload_images/9610720-527471279d41fe4e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####3.带图片文字描述型。
![QQ20180509-1340073.png](https://upload-images.jianshu.io/upload_images/9610720-0c0a426a6a9184af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我这里提供了几个数据源协议，可以自定义界面的所有view，只需要实现即可：
```
//自定义顶部view
- (UIView *)customTopView;
//自定义底部view
- (UIView *)customBottomView;
//长按图片弹出View
- (UIView *)customLongPressView;
```

与此同时，还提供了几种拓展属性，方便使用。如果觉得好用的话，求一个star。
