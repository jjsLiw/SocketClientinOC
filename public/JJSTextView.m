//
//  JJSTextView.m
//  MyClient
//
//  Created by liw on 2021/5/22.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "JJSTextView.h"

@implementation JJSTextView

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor: [UIColor redColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor redColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [self viewWithTag:999].alpha = 1 ;
        [self.limitCountLabel setHidden:NO];
    }
    else
    {
        [self viewWithTag:999].alpha = 0;
        if (!self.fromMS) {
            [self.limitCountLabel setHidden:YES];
        }else{
            [self.limitCountLabel setHidden:NO];
        }

    }
    
    if (self.limitCount != 0) {
//        [self.limitCountLabel setHidden:YES];  //add by billy
        if (self.text.length > self.limitCount) {
            NSString *toBeString = self.text;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
#pragma clang diagnostic pop
            if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
                UITextRange *selectedRange = [self markedTextRange];
                //获取高亮部分
                UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (!position) {
                    if (toBeString.length > self.limitCount) {
                        self.text = [toBeString substringToIndex:self.limitCount];
                    }
                }
                // 有高亮选择的字符串，则暂不对文字进行统计和限制
                else{
                }
            }
            // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            else{
                if (toBeString.length > self.limitCount) {
                    self.text = [toBeString substringToIndex:self.limitCount];
                }
            }
        }
    }
    
    if (self.showWordCount) {
        CGFloat right = 15;
        if (self.placeholderMargin > 0 && self.placeholderMargin <= 20) {
            right = self.placeholderMargin;
        }
        self.wordCountLabel .frame=CGRectMake(right,self.contentSize.height-26,self.bounds.size.width - (right * 2),  16);
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",[self text].length,self.limitCount];
    }
    if (self.textDidChangeBlock) {
        self.textDidChangeBlock();
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            CGFloat left = 15;
            if (self.placeholderMargin > 0 && self.placeholderMargin <= 20) {
                left = self.placeholderMargin;
            }
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(left,8,self.bounds.size.width - (left * 2),self.bounds.size.height - 16)];
            
            _limitCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width-100, self.bounds.size.height-15-16, 70, 16)];
            [_limitCountLabel setFont: [UIFont systemFontOfSize:13]];
            [_limitCountLabel setTextColor:[UIColor redColor]];
            [_limitCountLabel setTextAlignment:NSTextAlignmentRight];
//            [_limitCountLabel setBackgroundColor: [UIColor blueColor]];
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
#else
            placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
#endif
            placeHolderLabel.numberOfLines = 0;
            if (self.placeholderFont) {
                placeHolderLabel.font = self.placeholderFont;
            } else {
                placeHolderLabel.font = [UIFont systemFontOfSize:16];
            }
            placeHolderLabel.backgroundColor = [UIColor grayColor];
            placeHolderLabel.textColor = [UIColor redColor];
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            placeHolderLabel.contentMode = UIViewContentModeTop;
            [self addSubview:placeHolderLabel];
            [_limitCountLabel setText:self.limitString];
            [self addSubview:_limitCountLabel];
        }
        if (self.placeholderlineSpace > 0) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:self.placeholderlineSpace];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.placeholder length])];
            [placeHolderLabel setAttributedText:attributedString];
        } else {
            placeHolderLabel.text = self.placeholder;
        }
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if (self.wordCountLabel == nil && self.showWordCount) {
        CGFloat right = 15;
        if (self.placeholderMargin > 0 && self.placeholderMargin <= 20) {
            right = self.placeholderMargin;
        }
        self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(right,self.contentSize.height-26,self.bounds.size.width - (right * 2),  16)];
        [self addSubview:self.wordCountLabel];
        self.wordCountLabel.tag = 1999;
        self.wordCountLabel.textColor = [UIColor redColor];
        
        self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    }
    
    if (self.showWordCount) {
        CGFloat right = 15;
        if (self.placeholderMargin > 0 && self.placeholderMargin <= 20) {
            right = self.placeholderMargin;
        }
        self.wordCountLabel .frame=CGRectMake(right,self.contentSize.height-26,self.bounds.size.width - (right * 2),  16);
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",[self text].length,self.limitCount];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [self viewWithTag:999].alpha = 1;
    }
    
    [super drawRect:rect];
}

@end
