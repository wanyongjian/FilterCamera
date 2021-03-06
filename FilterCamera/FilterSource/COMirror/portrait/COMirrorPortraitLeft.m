//
//  YJHalfGrayFilter.m
//  iOSOpenGl
//
//  Created by 万 on 2018/5/20.
//  Copyright © 2018年 wan. All rights reserved.
//

#import "COMirrorPortraitLeft.h"


NSString *const YJMirrorPortraitFragmentShaderString = SHADER_STRING
(
 precision highp float;
 
 varying vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;

 void main()
 {
     vec2 textureCoordinate2 = vec2(1.0-textureCoordinate.x,textureCoordinate.y);
     vec4 color2 = texture2D(inputImageTexture, textureCoordinate2);
     vec4 color = texture2D(inputImageTexture, textureCoordinate);
     vec4 desColor;
     if(textureCoordinate.x < 0.5){
         desColor = color;
     }else{
         desColor = color2;
     }
     gl_FragColor = desColor;
 }
 );

@implementation COMirrorPortraitLeft

- (instancetype)init
{
    if (self = [super initWithFragmentShaderFromString:YJMirrorPortraitFragmentShaderString]) {
    }
    return self;
}
@end
