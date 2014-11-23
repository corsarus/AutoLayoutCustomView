//
//  CCRBoxedTextView.m
//  AutoLayoutCustomView
//
//  Created by Catalin (iMac) on 19/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "CCRBoxedTextView.h"

@interface CCRBoxedTextView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CCRBoxedTextView

CGFloat static kCCRTextPadding = 5.0;

- (instancetype)initWithAttributtedString:(NSAttributedString *)string
{
    if (!(self = [super init])) return nil;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.attributedText = string;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.contentLabel];
    self.backgroundColor = [self randomColor];
    
    return self;
}

- (void)updateConstraints
{
    // Pin the UILabel to the four edges of the text box
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[label]-(padding)-|"
                                                                options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:@{@"padding": @(kCCRTextPadding)}
                                                                   views:@{@"label": self.contentLabel}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]-(padding)-|"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:@{@"padding": @(kCCRTextPadding)}
                                                                   views:@{@"label": self.contentLabel}]];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // Help Auto Layout figure out the intrinsic content size of a multi-line label
    self.contentLabel.preferredMaxLayoutWidth = self.bounds.size.width - 2 * kCCRTextPadding;
    [super layoutSubviews];
}


- (UIColor *)randomColor
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    
    // any color but black
    while (red == 0.0 && green == 0.0 && blue == 0.0) {
        red = arc4random() / INT_MAX;
        green = arc4random() / INT_MAX;
        blue = arc4random() / INT_MAX;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
