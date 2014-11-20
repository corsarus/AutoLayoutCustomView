//
//  ViewController.m
//  AutoLayoutCustomView
//
//  Created by Catalin (iMac) on 19/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "ViewController.h"
#import "CCRBoxedTextContainerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                                                 attributes:[self randomAttributes]];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor"
                                                                  attributes:[self randomAttributes]];
    
    NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:@"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                                                  attributes:[self randomAttributes]];
    
    NSArray *attributedStrings = @[string1, string2, string3];
    
    CCRBoxedTextContainerView *boxedTextContainer = [[CCRBoxedTextContainerView alloc] initWithAttributedStringArray:attributedStrings];
    [self.view addSubview:boxedTextContainer];
    
    // Pin the container subview to the main view edges
    NSDictionary *subviews = NSDictionaryOfVariableBindings(boxedTextContainer);
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[boxedTextContainer]|"
                                                                       options:NSLayoutFormatAlignAllCenterY
                                                                       metrics:nil
                                                                         views:subviews]];
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[boxedTextContainer]|"
                                                                       options:NSLayoutFormatAlignAllCenterX
                                                                       metrics:nil
                                                                         views:subviews]];
}


- (NSDictionary *)randomAttributes
{
    NSArray *fontFamilies = [UIFont familyNames];
    //NSUInteger randomIndex = (((NSUInteger) (arc4random() % ((unsigned)fontFamilies.count)) / fontFamilies.count));
    NSUInteger randomIndex = (NSUInteger) (arc4random() % (unsigned)fontFamilies.count);
    
    // Random font size between 10 and 20
    NSUInteger randomSize = (NSUInteger)(10 + arc4random() % 10);
    UIFont *font = [UIFont fontWithName:fontFamilies[randomIndex] size:randomSize];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    UIColor *color = [UIColor blackColor];
    
    return @{
      NSParagraphStyleAttributeName : paragraphStyle,
      NSFontAttributeName : font,
      NSForegroundColorAttributeName : color};
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
