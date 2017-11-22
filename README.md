# TSMenuLabel是一个给Label加menuController的控件

### 0. 需求分析
需要复制商品标题,需要在Label上加MenuController,但是UILabel是自己不带MenuController,所以自己写了一个

### 1. 效果 
TSMenuLabel 是继承自UILabel的控件,给UILabel添加了手势,并添加了menuViewController,点击会有事件

效果查看:
![效果图](https://github.com/TsnumiDC/TSMenuLabel/blob/master/Untitled.gif?raw=true)

### 2. 封装方法

```
/**
 初始化方法

 @param menuType 弹窗类型
 @param gestureType 手势类型
 @return 返回label
 */
+ (instancetype)mneuLabelWithMenuType:(TSMneuLabelMenuType)menuType
                       andGestureType:(TSMneuLabelGestureType)gestureType;
```
### 3. 原理

让UILabel能处理MenuControler,需要设置以下代码
```
- (BOOL)canBecomeFirstResponder{
    return YES;
}

/**
 * label能执行哪些操作(比如copy, paste等等)
 * @return  YES:支持这种操作
 *  由于这里需要实现自定义的中文菜单，而不是使用默认的，所以这里选择NO
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    //这里也是间接影响显示在UIMenuController的控件
    if (action == @selector(copy:)) {
        return YES;//如果要去掉 拷贝 这里返回NO
    }else if (action == @selector(flag:)){
        return NO;//这里如果是no 就不允许操作和显示
    }else if (action == @selector(approve:)){
        return YES;
    }else if (action == @selector(deny:)){
        return YES;
    }else{
        return [super canPerformAction:action withSender:sender];
    }
}

```
### 4. 扩展

更多手势和事件需要自己添加,添加方法:
1. 添加事件

在枚举中添加一个枚举,比如`TSMneuLabelTypeDemo`
```
typedef NS_ENUM(NSInteger, TSMneuLabelMenuType) {
    TSMneuLabelTypeDefault,//啥也没有
    TSMneuLabelTypeCopy = 1,//只有复制
    TSMneuLabelTypeDemo,//栗子
    
};
```
在处理手势中添加menu
```
-(void)handleTap:(UIGestureRecognizer*) recognizer
{
        case TSMneuLabelTypeDemo:{
            
            UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"abc" action:@selector(flag:)];
            UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve" action:@selector(approve:)];
            UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(deny:)];
            [menu setMenuItems:@[approve,flag,deny]];

        }
            break;
}
```
添加事件
```

- (void)approve:(id)sender {
    NSLog(@"Approve");
}
```
允许事件
```
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    //这里也是间接影响显示在UIMenuController的控件
    if (action == @selector(copy:)) {
        return YES;//如果要去掉 拷贝 这里返回NO
    }else if (action == @selector(flag:)){
        return NO;//这里如果是no 就不允许操作和显示
    }else if (action == @selector(approve:)){
        return YES;
    }else if (action == @selector(deny:)){
        return YES;
    }else{
        return [super canPerformAction:action withSender:sender];
    }
}
```
2. 添加手势

首先添加一个枚举
```
typedef NS_ENUM(NSInteger, TSMneuLabelGestureType) {
    TSMneuLabelGestureTypeNone,//强制不作处理
    TSMneuLabelGestureTypeDefault = 0,//没赋值会走tap
    TSMneuLabelGestureTypeTap,//默认单击
    TSMneuLabelGestureTypeLongTap,//长按
};

```

然后添加一个手势
```
- (void)setGestureType:(TSMneuLabelGestureType)gestureType{
    
    //移除所有手势
    for (UIGestureRecognizer *ges in self.gestureRecognizers) {
        [self removeGestureRecognizer:ges];
    }
    
    switch (gestureType) {
        case TSMneuLabelGestureTypeTap: {
            
            UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            touch.numberOfTapsRequired = 1;
            [self addGestureRecognizer:touch];
        }
            break;
        case TSMneuLabelGestureTypeLongTap: {
            
            UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:touch];
        }
            break;
            
        default:
            break;
    }

}
```

3. 更多

- 抛出事件可以利用已经定义好的Block来处理
```
typedef void(^TSMneuLabelHandler)(TSMneuLabel * menuLabel);

```





