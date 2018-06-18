//
//  COPhotoDisplayController.m
//  FilterCamera
//
//  Created by wanyongjian on 2018/6/1.
//  Copyright © 2018年 wan. All rights reserved.
//

#import "COPhotoDisplayController.h"
#import "COPhotoFilterView.h"
#import "COPhotoItemController.h"

#define kCameraFilterViewHeight (kScreenHeight-kScreenWidth*4.0f/3.0f)

@interface COPhotoDisplayController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) COPhotoFilterView *photoFilterView;
@end

@implementation COPhotoDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, 100, 300, 300);
    [self.view addSubview:self.imageView];
    
    GPUImagePicture  *pic = [[GPUImagePicture alloc]initWithImage:self.sourceImage];
    NSAssert(pic!=nil, @"self.sourceImage是空");
    GPUImageFilter *filter = [[self.filterClass alloc]init];
    [pic addTarget:filter];
    [filter useNextFrameForImageCapture];
    [pic processImage];
    
    UIImage *image = [filter imageFromCurrentFramebufferWithOrientation:self.sourceImage.imageOrientation];
    image = [UIImage clipOrientationImage:image withRatio:1.0];
    UIImage *fixImage = [image fixOrientation];
    CGFloat ratio = image.size.height/(CGFloat)image.size.width;
    self.imageView.image = fixImage;
//    self.imageView.image = self.sourceImage;
    self.imageView.frame = CGRectMake(0, 100, kScreenWidth, kScreenWidth*ratio);    
    
    [self setFilterGroupUI];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)viewWillAppear:(BOOL)animated{
//    [self addNavigationItemWithTitle:@"返回" type:ItemTypeLeft selector:@selector(backAction)];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)setFilterGroupUI{
    weakSelf();
    _photoFilterView = [[COPhotoFilterView alloc]init];
    _photoFilterView.frame = CGRectMake(0, kScreenHeight-kCameraFilterViewHeight, kScreenWidth, kCameraFilterViewHeight);
    [self.view addSubview:self.photoFilterView];
    self.photoFilterView.filterClick = ^(LUTFilterGroupModel *model) {
        NSLog(@"%@,%@,%@,%@",model.name,model.type,model.path,model.imagePath);
        COPhotoItemController *vc = [[COPhotoItemController alloc]init];
        [wself.navigationController pushViewController:vc animated:NO];
        vc.model = model;
        vc.sourceImage = wself.sourceImage;
    };
}
@end