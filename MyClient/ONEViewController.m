//
//  ONEViewController.m
//  MyClient
//
//  Created by liw on 2021/5/24.
//  Copyright © 2021 gongwenkai. All rights reserved.
//

#import "ONEViewController.h"
#import <Photos/Photos.h>
#import "LVColorPickerView.h"

@interface ONEViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (nonatomic, strong)UIImagePickerController *pickController;

@end

@implementation ONEViewController


- (IBAction)openAbum:(id)sender {
    self.pickController = [[UIImagePickerController alloc]init];

    //此处判断相机是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"camera error");
        return;
    }

    //UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    self.pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   //指定媒体类型是什么 照片还是视频
   //默认为 照片
   //通过下一行方法可以返回支持的类型
  // [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
   //查到很多资料都是"kUTTypeMovie","kUTTypeImage"这两个参数名称但是我测试后发现已经变成下面这两种名称
   //"public.image"  照片
   //"public.movie"  视频
   //如果全部支持可以这么设置
   //self.pickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
   //单个支持
   self.pickController.mediaTypes = @[@"public.image"];
   //代理设置
   self.pickController.delegate = self;
   //是否提供编辑交互界面 比如说拍完照之后的编辑页面(缩放,剪裁等)
   //使用内置编辑控件时，图像选择器控制器会强制执行某些选项。对于照片，强制执行方形裁剪以及最大像素尺寸。对于视频，选择器强制执行最大电影长度和分辨率。如果要让用户指定自定义裁剪，则必须提供自己的编辑UI。
   self.pickController.allowsEditing = NO;
   //是否显示相机控制按钮
   //self.pickController.showsCameraControls = NO;
    //自定义相机控制页面
   //self.pickController.cameraOverlayView = self.cameraOverLayView;
   //如果不需要自定义控制页面可以省略上面两行
   //设置闪光灯模式
//   self.pickController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
   //相册权限检测 需要导入 #import <Photos/Photos.h> 框架
   //用户还没有选择
   //PHAuthorizationStatusNotDetermined = 0
   // 客户端未被授权访问。用户不能改变状态,可能是由于家长控制
   //PHAuthorizationStatusRestricted = 1
   // 用户明确拒绝
   //PHAuthorizationStatusDenied = 2
   // 用户同意访问
   //PHAuthorizationStatusAuthorized = 3
   [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      //相册访问权限
      if (status == PHAuthorizationStatusAuthorized) {
          NSLog(@"Authorized");
          
          dispatch_async(dispatch_get_main_queue(), ^{
              [self presentViewController:self.pickController animated:YES completion:nil];
          });
          
          
       }else{
          NSLog(@"Denied or Restricted");
       }
   }];


}

-(void)opencamera{
    
    //此处判断相机是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"camera error");
        return;
    } 
    self.pickController = [[UIImagePickerController alloc]init];
    self.pickController.sourceType = UIImagePickerControllerSourceTypeCamera;
   //指定媒体类型是什么 照片还是视频
   //默认为 照片
   //通过下一行方法可以返回支持的类型
   [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
   //查到很多资料都是"kUTTypeMovie","kUTTypeImage"这两个参数名称但是我测试后发现已经变成下面这两种名称
   //"public.image"  照片
   //"public.movie"  视频
   //如果全部支持可以这么设置
   //self.pickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
   //单个支持
   self.pickController.mediaTypes = @[@"public.image"];
   //代理设置
   self.pickController.delegate = self;
   //是否提供编辑交互界面 比如说拍完照之后的编辑页面(缩放,剪裁等)
   //使用内置编辑控件时，图像选择器控制器会强制执行某些选项。对于照片，强制执行方形裁剪以及最大像素尺寸。对于视频，选择器强制执行最大电影长度和分辨率。如果要让用户指定自定义裁剪，则必须提供自己的编辑UI。
   self.pickController.allowsEditing = NO;
   //是否显示相机控制按钮
   //self.pickController.showsCameraControls = NO;
    //自定义相机控制页面
   //self.pickController.cameraOverlayView = self.cameraOverLayView;
   //如果不需要自定义控制页面可以省略上面两行
   //设置闪光灯模式
   self.pickController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
   //相册权限检测 需要导入 #import <Photos/Photos.h> 框架
   //用户还没有选择
   //PHAuthorizationStatusNotDetermined = 0
   // 客户端未被授权访问。用户不能改变状态,可能是由于家长控制
   //PHAuthorizationStatusRestricted = 1
   // 用户明确拒绝
   //PHAuthorizationStatusDenied = 2
   // 用户同意访问
   //PHAuthorizationStatusAuthorized = 3
   [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
      //相册访问权限
      if (status == PHAuthorizationStatusAuthorized) {
          NSLog(@"Authorized");
          
          dispatch_async(dispatch_get_main_queue(), ^{
              [self presentViewController:self.pickController animated:YES completion:nil];
          });
          
          
       }else{
          NSLog(@"Denied or Restricted");
       }
   }];


}

// 控制器不会自己dismiss 需要我们手动在相应的地方实现
// 这两个代理方法只会收到其中一个，取决于用户的点击情况
//结束采集之后 之后怎么处理都在这里写 通过Infokey取出相应的信息  Infokey可在进入文件中查看
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    //查看是视频还是照片  public.image 或 public.movie
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {//照片
        UIImage* editedImage =(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage]; //取出编辑过的照片
        UIImage* originalImage =(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];//取出原生照片
        UIImage* imageToSave = nil;
        if(editedImage){
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        //将新图像（原始图像或已编辑）保存到相机胶卷
//        UIImageWriteToSavedPhotosAlbum(imageToSave,nil,nil,nil);
        
        self.imv.image = imageToSave;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    if ([mediaType isEqualToString:@"public.movie"]) {//视频
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
}
//用户点击了取消


- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton  *pivcBB = [[UIButton alloc]initWithFrame:CGRectMake(30, 300, 300, 300)];
    [self.view addSubview:pivcBB];
    [pivcBB addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    LVColorPickerView  *pivc = [[LVColorPickerView alloc]initWithFrame:CGRectMake(30, 300, 300, 300)];
    pivc.touchBLock = ^{
        NSLog(@"pivc bei touch");
    };
    [self.view addSubview:pivc];
    
}
-(void)action:(id)bn{
    NSLog(@"%s 这是按钮事件啦",__func__);
    
}



@end
