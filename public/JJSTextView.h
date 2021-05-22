//
//  JJSTextView.h
//  MyClient
//
//  Created by liw on 2021/5/22.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJSTextView : UITextView
{

    NSString *placeholder;
    UIColor *placeholderColor;
    @private
    UILabel *placeHolderLabel;
}

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic , assign) BOOL fromMS;
@property (nonatomic , assign) BOOL showWordCount;//显示当前字数
@property (nonatomic , strong) UILabel *wordCountLabel;  //当前字数的标签

@property (nonatomic , strong) UILabel *limitCountLabel;  //最大字数限制的标签
@property (nonatomic , strong) NSString *limitString;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) CGFloat placeholderlineSpace;
/**
 占位字符距离左右的宽度，须大于0且小于等于20
 **/
@property (nonatomic, assign) CGFloat placeholderMargin;
/**
 占位字符字体
 **/
@property (nonatomic, strong) UIFont *placeholderFont;
//字数限制
@property(nonatomic) int limitCount;

-(void)textChanged:(NSNotification*)notification;


@property (nonatomic, copy) void (^textDidChangeBlock)(void);

@end

NS_ASSUME_NONNULL_END
