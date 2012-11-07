//
//  ESVViewController.m
//  ExampleSingleView
//
//  Created by Mason Weems on 11/5/12.
//  Copyright (c) 2012 Mason Weems. All rights reserved.
//

#import "ESVViewController.h"
#define CLASS_DEBUG 1
#import "DDGMacros.h"

@interface ESVViewController ()

@end

@implementation ESVViewController

- (void)viewDidLoad
{
    DDGTrace();
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    NSString *storyboardName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        storyboardName = @"MainStoryboard_iPad";
    } else {
        storyboardName = @"MainStoryboard_iPhone";
    }
    storyboardName = @"MainStoryboard_iPhone";

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    self.leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
    self.centerController = [storyboard instantiateViewControllerWithIdentifier:@"centerViewController"];
    self.rightController = [storyboard instantiateViewControllerWithIdentifier:@"rightViewController"];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
