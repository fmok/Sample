// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Extends the UIImage class to support resizing/cropping

#import <UIKit/UIkit.h>

@interface UIImage (Resize)
- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

- (UIImage*)imageScaledToSize:(CGSize)newSize;

- (UIImage*)imageScaledToSizeWithSameAspectRatio:(CGSize)targetSize;

- (UIImage*)rotate:(UIImageOrientation)orient;

- (UIImage*)resizeImageWithNewSize:(CGSize)newSize;

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
//图片旋转的分类方法
- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
//从图片的中心 拉伸图片的静态方法
+ (UIImage*)resizedImage:(NSString*)name;
//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)fixCameraImageToRightOrientation:(UIImage *)aImage;
/**
 *  压缩图片至(1440×2560)，最大maxSize支持500KB
 *
 *  @param maxSize 最大图片大小
 *
 *  @return NSData
 */
- (NSData *)resizeImageOfMaxSize:(NSInteger)maxSize;

@end
