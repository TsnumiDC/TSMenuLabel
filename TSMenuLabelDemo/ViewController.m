//
//  ViewController.m
//  TSMenuLabelDemo
//
//  Created by Dylan Chen on 2017/11/22.
//  Copyright © 2017年 Dylan Chen. All rights reserved.
//

#import "ViewController.h"
#import "TSMneuLabel.h"

@interface ViewController ()

@property (strong, nonatomic)TSMneuLabel * tapCopyLabel;//单击拷贝
@property (strong, nonatomic)TSMneuLabel * longCopyLabel;//长按拷贝

@property (strong, nonatomic)TSMneuLabel * otherLabel;//自定义菜单

@property (strong, nonatomic)TSMneuLabel * normalLabel;//正常,不作操作


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self layoutSubViews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configSubViews{
    
    self.navigationItem.title = @"给Label 加 menu";
    
    [self.view addSubview:self.tapCopyLabel];
    [self.view addSubview:self.longCopyLabel];
    [self.view addSubview:self.otherLabel];
    [self.view addSubview:self.normalLabel];

}

- (void)layoutSubViews{
    
    self.tapCopyLabel.frame = CGRectMake(100, 100, 150, 32);
    self.longCopyLabel.frame = CGRectMake(100, 100 + 48, 150, 32);
    self.otherLabel.frame = CGRectMake(100, 100 + 48 +48, 190, 32);
    self.normalLabel.frame = CGRectMake(100, 100+48 +48 +48, 150, 32);
//    self.tapCopyLabel.center.x = [UIScreen mainScreen].bounds.size.width/2;

}

#pragma mark - Lazy
- (TSMneuLabel *)tapCopyLabel{
    if (_tapCopyLabel == nil) {
        _tapCopyLabel = [TSMneuLabel mneuLabelWithMenuType:TSMneuLabelTypeCopy andGestureType:TSMneuLabelGestureTypeTap];
        _tapCopyLabel.text = @"点击弹出复制";
        _tapCopyLabel.backgroundColor = [UIColor redColor];
    }
    return _tapCopyLabel;
}

- (TSMneuLabel *)longCopyLabel{
    if (_longCopyLabel == nil) {
        _longCopyLabel = [TSMneuLabel mneuLabelWithMenuType:TSMneuLabelTypeCopy andGestureType:TSMneuLabelGestureTypeLongTap];
        _longCopyLabel.text = @"长按弹出复制";
        _longCopyLabel.backgroundColor = [UIColor redColor];
    }
    return _longCopyLabel;
}

- (TSMneuLabel *)otherLabel{
    if (_otherLabel == nil) {
        _otherLabel = [TSMneuLabel mneuLabelWithMenuType:TSMneuLabelTypeDemo andGestureType:TSMneuLabelGestureTypeTap];
        _otherLabel.text = @"点击弹出自定义menu";
        _otherLabel.backgroundColor = [UIColor redColor];
    }
    return _otherLabel;
}

- (TSMneuLabel *)normalLabel{
    if (_normalLabel == nil) {
        _normalLabel = [TSMneuLabel mneuLabelWithMenuType:TSMneuLabelTypeDemo andGestureType:TSMneuLabelGestureTypeNone];
        _normalLabel.text = @"正常的不作处理的";
        _normalLabel.backgroundColor = [UIColor redColor];
    }
    return _normalLabel;
}


#pragma mark - dealloc

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
