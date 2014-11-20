//
//  CCRBoxedTextContainerView.m
//  AutoLayoutCustomView
//
//  Created by Catalin (iMac) on 19/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "CCRBoxedTextContainerView.h"
#import "CCRBoxedTextView.h"

@interface CCRBoxedTextContainerView ()

@property (nonatomic, strong) NSArray *attributedStrings;
@property (nonatomic) BOOL addedBoxes;

@end

@implementation CCRBoxedTextContainerView

- (instancetype)initWithAttributedStringArray:(NSArray *)strings
{
    if (!(self = [super init])) return nil;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.attributedStrings = strings;
    
    return self;
    
}


- (void)layoutSubviews
{
    if (!self.addedBoxes) {
        CCRBoxedTextView *lastBoxOnLeftSide = [[CCRBoxedTextView alloc] initWithAttributtedString: self.attributedStrings[0]];
        [self addSubview:lastBoxOnLeftSide];
        CCRBoxedTextView *lastBoxOnRightSide = [[CCRBoxedTextView alloc] initWithAttributtedString: self.attributedStrings[1]];
        [self addSubview:lastBoxOnRightSide];
       
        // Add the first two text boxes at the top
        // The boxes are the same width
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topLeftBox][topRightView(==topLeftBox)]|"
                                                                      options:NSLayoutFormatAlignAllTop
                                                                      metrics:nil
                                                                        views:@{@"topLeftBox": lastBoxOnLeftSide,
                                                                                @"topRightView": lastBoxOnRightSide}]];
        // Pin the first subview to the top left
        [self addConstraint:[NSLayoutConstraint constraintWithItem:lastBoxOnLeftSide
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0 constant:0.0]];
        
        for (NSUInteger i = 2; i < self.attributedStrings.count; i++) {
            
            // Make sure the subviews frames are right in order to get their center
            [super layoutSubviews];
            
            CCRBoxedTextView *boxedTextView = [[CCRBoxedTextView alloc] initWithAttributtedString: self.attributedStrings[i]];
            [self addSubview:boxedTextView];
                
            // Pin the subview under the last subview which is upper in its column
            if (lastBoxOnLeftSide.center.y <= lastBoxOnRightSide.center.y) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:lastBoxOnLeftSide
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0 constant:0.0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0 constant:0.0]];
                
                // The subview has the same width as its top sibling
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:lastBoxOnLeftSide
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:1.0 constant:0.0]];
                
                lastBoxOnLeftSide = boxedTextView;
            } else {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:lastBoxOnRightSide
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0 constant:0.0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1.0 constant:0.0]];
                
                // The subview has the same width as its top sibling
                [self addConstraint:[NSLayoutConstraint constraintWithItem:boxedTextView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:lastBoxOnRightSide
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:1.0 constant:0.0]];

                lastBoxOnRightSide = boxedTextView;
            }
        }
        
        self.addedBoxes = YES;
    }
}

@end
