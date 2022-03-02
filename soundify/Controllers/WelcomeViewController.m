//
//  WelcomeViewController.m
//  soundify
//
//  Created by Raul Max on 01/03/22.
//

#import "WelcomeViewController.h"
#import "UIViewExtension.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (UIButton *)signInButton {
  UIButton *button = [UIButton new];
  button.backgroundColor = [UIColor systemRedColor];
  button.layer.borderWidth = 2;
  button.clipsToBounds = YES;
  
  [button setTitle:@"Sign In with Spotify" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor systemBackgroundColor] forState:UIControlStateNormal];
  
  return button;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.title = @"Soundify";
  self.view.backgroundColor = [UIColor systemGreenColor];
  
  [self.view addSubview:self.signInButton];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  self.signInButton.frame = CGRectMake(20, self.view.frame.size.height - 50 - self.view.safeAreaInsets.bottom, self.view.frame.size.width, 50);
  self.signInButton.layer.cornerRadius = self.signInButton.frame.size.height / 2;
  
  [self.signInButton addTarget:self action:@selector(handlePress:) forControlEvents:UIControlEventTouchUpInside];
  
  printf("%f", self.view.frame.size.height);
}

- (void)handlePress: (UIButton *) sender {
  printf("Button pressed!");
}

@end
