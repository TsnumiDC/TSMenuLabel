//
//  TSMneuLabel.m
//  JiHeShi
//
//  Created by Dylan Chen on 2017/11/22.
//  Copyright © 2017年 JiHes. All rights reserved.
//

#import "TSMneuLabel.h"

@implementation TSMneuLabel

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

#pragma mark - Init
+ (instancetype)mneuLabelWithMenuType:(TSMneuLabelMenuType)menuType
                           andGestureType:(TSMneuLabelGestureType)gestureType{
    
    return  [[self alloc]initWithMenuType:menuType andGestureType:gestureType];
}

- (instancetype)initWithMenuType:(TSMneuLabelMenuType)menuType
               andGestureType:(TSMneuLabelGestureType)gestureType{
    
    return [self initWithFrame:CGRectZero andMenuType:menuType andGestureType:gestureType];
}

- (instancetype)initWithFrame:(CGRect)frame
                  andMenuType:(TSMneuLabelMenuType)menuType
               andGestureType:(TSMneuLabelGestureType)gestureType{
    
    if (self = [self initWithFrame:frame]) {
        
        self.menuType = menuType;
        self.gestureType = gestureType;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 * 让label可以响应用户操作
 */
- (void)setup{
    self.userInteractionEnabled = YES;
    
    if(self.gestureType == TSMneuLabelGestureTypeDefault){
        //如果是没有选择
        self.gestureType = TSMneuLabelGestureTypeTap;
    }

}

-(void)handleTap:(UIGestureRecognizer*) recognizer{
    //是当前的对象成为第一响应者
    [self becomeFirstResponder];
    
    //创建UIMenuController的控件
 
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO];
    switch (self.menuType) {
        case TSMneuLabelTypeDefault:{
            //默认不加
        }
            break;
        case TSMneuLabelTypeCopy:{
            //加复制
            [menu setMenuItems:@[]];
        }
            break;
        case TSMneuLabelTypeDemo:{
            
            UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"abc" action:@selector(flag:)];
            UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve" action:@selector(approve:)];
            UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(deny:)];
            [menu setMenuItems:@[approve,flag,deny]];

        }
            break;
            
        default:
            break;
    }

    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - Action

- (void)copy:(id)sender {
    NSLog(@"copy");
    [UIPasteboard generalPasteboard].string = self.text?self.text:@"";
    NSLog(@"%@",self.text);
}

- (void)flag:(id)sender {
    NSLog(@"国旗");
}

- (void)approve:(id)sender {
    NSLog(@"Approve");
}

- (void)deny:(id)sender {
    NSLog(@"Deny");
}

#pragma mark - System
/**
 * 让label有资格成为第一响应者
 */
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
@end
