//
//  ViewController.m
//  test1
//
//  Created by liw on 2021/5/22.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "ViewController.h"

#import "JJSTextView.h"

@interface ViewController ()
{
    JJSTextView *vew;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    vew= [[JJSTextView alloc]initWithFrame:CGRectMake(10, 100, 300, 500)];
    vew.backgroundColor = [UIColor lightGrayColor];
    vew.text = @"fasdfjasdlfjalsjdfljadjoeqewolfdfajdflaldjflajdlfjalsdjfljsdljsdlfjalsjdfljasdlf";
    [self.view addSubview:vew];
    __weak typeof(self) weakSelf = self;
    vew.textDidChangeBlock = ^{
      
        [weakSelf dothing];
    };
    
}
-(void)dothing{
    vew.text = [vew.text stringByAppendingString:@","];
}


@end
