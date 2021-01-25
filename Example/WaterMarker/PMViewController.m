//
//  PMViewController.m
//  WaterMarker
//
//  Created by iPaperman on 01/25/2021.
//  Copyright (c) 2021 iPaperman. All rights reserved.
//

#import "PMViewController.h"
#import "PMWaterMarker.h"

@interface PMViewController ()
@property (weak, nonatomic) IBOutlet PMWaterMarker *m1;
@property (weak, nonatomic) IBOutlet PMWaterMarker *m2;
@end

@implementation PMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.m1.text = @"水印1";
    self.m1.dx = 40;
    self.m1.dy = 20;
    self.m2.text = @"水印2";
    self.m2.dx = 80;
    self.m2.dy = 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
