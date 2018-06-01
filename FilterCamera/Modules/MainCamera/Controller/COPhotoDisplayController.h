//
//  COPhotoDisplayController.h
//  FilterCamera
//
//  Created by wanyongjian on 2018/6/1.
//  Copyright © 2018年 wan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COPhotoDisplayController : UIViewController

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) GPUImageFilter *imageFilter;
@end
