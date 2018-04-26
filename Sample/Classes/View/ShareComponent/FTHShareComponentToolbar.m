//
// Created by 周东兴 on 2017/3/8.
// Copyright (c) 2017 JIEMIAN. All rights reserved.
//

#import <YYCategories/YYCategories.h>
#import "FTHShareComponentToolbar.h"
#import "UIImage+Alpha.h"


@interface ShareComponentBarItem : UIButton
@property(nonatomic, assign) FTHSocialPlatformType platformType;
@property(nonatomic, assign) UIControlContentHorizontalAlignment contentHorizontalAlignment1;

@property(nonatomic, assign) BOOL isInstalled;
@end

@implementation ShareComponentBarItem

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize size = [self imageForState:UIControlStateNormal].size;

	return CGRectMake((CGRectGetWidth(contentRect) - size.width) * 0.5f, (70 - size.height) * 0.5f, size.width, size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
	return CGRectMake(0, 60, CGRectGetWidth(contentRect), 20);
}

- (CGSize)intrinsicContentSize {
	return CGSizeMake(70, 70);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!self.isInstalled) {
        self.highlighted = YES;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (!self.isInstalled) {
        self.highlighted = YES;
    }
}

@end




@interface FTHShareComponentToolbar ()
@property(nonatomic, strong) NSArray<ShareComponentBarItem *> *barItems;
@property(nonatomic, strong) UILabel *textLabel;
@end

@implementation FTHShareComponentToolbar

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0f / 255 green:245.0f / 255 blue:245.0f / 255 alpha:1];
	    
	    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:items.count];
        for (int i = 0; i < items.count; ++i) {
            [mutableArray addObject:[self barItem:items[i]]];
        }
        _barItems = [NSArray arrayWithArray:mutableArray];
	    
	    _textLabel = [[UILabel alloc] init];
	    _textLabel.text = @"分享到";
	    _textLabel.textColor = SRGBCOLOR_HEX(0x959595);
	    _textLabel.textAlignment = NSTextAlignmentCenter;
	    _textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
	    [self addSubview:_textLabel];
    }
	
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    if (newSuperview) {
        self.shareViewContext(self, self.barItems);
        self.shareViewContext = nil;
    }
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	for (int i = 0; i < self.barItems.count; ++i) {
		CGRect frame = CGRectMake(0, 0, 70, 70);
		self.barItems[i].frame = frame;
		self.barItems[i].centerX = 50 + (i%4) * (CGRectGetWidth(self.bounds) - 100) / 3.f;
		self.barItems[i].centerY = 67.5 + (i/4) * 95;
	}
	
	_textLabel.frame = CGRectMake(0, 18.5, CGRectGetWidth(self.bounds), _textLabel.font.lineHeight);
}

- (void)startAnimation {
//    for (int i = 0; i < self.barItems.count; i++) {
//        self.barItems[i].transform = CGAffineTransformMakeTranslation(0, 130);
//        [UIView animateWithDuration:.225
//                              delay:0.001 * 40 * i
//             usingSpringWithDamping:0.5
//              initialSpringVelocity:0.5
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             self.barItems[i].transform = CGAffineTransformIdentity;
//                         }
//                         completion:nil];
//
//    }
}

#pragma mark - Private Methods

- (ShareComponentBarItem *)barItem:(NSDictionary *)info {
    ShareComponentBarItem *barItem = [[ShareComponentBarItem alloc] init];
    [barItem addTarget:self action:@selector(didPressBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [barItem setImage:[UIImage imageNamed:info[kFTHShareComponentBarItemImage]] forState:UIControlStateNormal];
    [barItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_s", info[kFTHShareComponentBarItemImage]]] forState:UIControlStateSelected];
	[barItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_u", info[kFTHShareComponentBarItemImage]]] forState:UIControlStateHighlighted];
    [barItem setTitle:info[kFTHShareComponentBarItemTitle] forState:UIControlStateNormal];
    [barItem setTitleColor:[UIColor colorWithRed:85.0f / 255 green:85.0f / 255 blue:85.0f / 255 alpha:1] forState:UIControlStateNormal];
	[barItem setTitleColor:[UIColor colorWithRed:85.0f / 255 green:85.0f / 255 blue:85.0f / 255 alpha:0.6] forState:UIControlStateHighlighted];
    barItem.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    barItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    barItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    barItem.platformType = (FTHSocialPlatformType) [info[kFTHShareComponentBarItemType] intValue];
	barItem.highlighted = ![info[kFTHShareComponentBarItemDisabled] boolValue];
    barItem.isInstalled = [info[kFTHShareComponentBarItemDisabled] boolValue];
    
    [self addSubview:barItem];

    return barItem;
}

#pragma mark - Target Methods

- (void)didPressBarItem:(ShareComponentBarItem *)barItem {
    if (barItem.isInstalled) {
        [self transmit:barItem.platformType];
    } else {
        [self transmitNotInstalled:barItem.platformType];
    }
}

#pragma mark -

- (void)transmit:(FTHSocialPlatformType)type {
    id <FTHShareComponentTransmit> deliver = (id <FTHShareComponentTransmit>) self.nextResponder.nextResponder;
    [deliver transmit:type];
}

- (void)transmitNotInstalled:(FTHSocialPlatformType)type {
    id <FTHShareComponentTransmit> deliver = (id <FTHShareComponentTransmit>) self.nextResponder.nextResponder;
    [deliver transmitNotInstalled:type];
}

@end
