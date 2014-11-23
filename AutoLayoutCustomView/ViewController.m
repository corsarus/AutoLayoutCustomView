//
//  ViewController.m
//  AutoLayoutCustomView
//
//  Created by Catalin (iMac) on 19/11/2014.
//  Copyright (c) 2014 Catalin Rosioru. All rights reserved.
//

#import "ViewController.h"
#import "CCRBoxedTextContainerView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize some random attributed strings
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                                                                 attributes:[self randomAttributes]];
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:@"Modus posse mea ad."
                                                                  attributes:[self randomAttributes]];
    
    NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:@"Mea at ridens timeam, sit periculis inciderint liberavisse id. Duo et dicant doctus meliore, cu cum delicata elaboraret, an euismod ancillae pri. Semper appareat sea ut, eum an unum insolens. Habeo idque ut quo."
                                                                  attributes:[self randomAttributes]];
    
    NSAttributedString *string4 = [[NSAttributedString alloc] initWithString:@"Dicta oporteat rationibus quo ut, an mel partem consequat. Ex semper fierent sapientem qui. Rebum explicari id duo, ferri oblique pro ad, quo id vide efficiendi. Vix ex natum graece euripidis, ex usu ponderum tincidunt, his inani noluisse appellantur at. Nam ne malis eligendi referrentur, dico delenit pertinax sea ei. Tale consectetuer duo eu. No dicta utamur definiebas qui, nulla discere luptatum te nec, regione viderer legendos cu eum."
                                                                  attributes:[self randomAttributes]];
    
    NSAttributedString *string5 = [[NSAttributedString alloc] initWithString:@"Impetus conceptam et mel, ea omnium appareat mea. Quo id integre dolores, duo dicunt impetus delenit ut. Ad nam suscipit accusata urbanitas. In nam voluptua oporteat."
                                                                  attributes:[self randomAttributes]];
    
    
    NSArray *attributedStrings = @[string1, string2, string3, string4, string5];
    
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
