//
//  ExpandViewController.m
//  AdMobileSDK
//
//  Created by Constantine Mureev on 12/16/11.
//

#import "MASTExpandViewController.h"

@implementation MASTExpandViewController

@synthesize adView;


#pragma mark - View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
