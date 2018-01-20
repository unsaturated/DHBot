/**
 * DH Bot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *  
 * DH Bot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with DH Bot. If not, see 
 * https://github.com/unsaturated/DHBot/blob/master/LICENSE.
 */

#import "DHMPagedOnboardingViewController.h"
#import "EAIntroPage+Extensions.h"
#import "DHMController.h"

@interface DHMPagedOnboardingViewController ()

@end

@implementation DHMPagedOnboardingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupIntroPages];
}

#pragma EAIntroPage Setup
-(void) setupIntroPages
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"DH Bot is a DreamHost sidekick";
    page1.desc = @"Manage users, domains, databases, check your account balance, and more.";
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onboard-treddy"]];
    page1.titleIconPositionY = self.view.frame.size.height / 2.0f - page1.titleIconView.frame.size.height / 2.0f;
    
    EAIntroPage *page1a = [EAIntroPage page];
    page1a.title = @"Unofficial app, officially great hosting";
    page1a.desc = @"You'll need a DreamHost account to get started. They provide great service and DH Bot is the unofficial app that complements it.";
    page1a.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onboard-dh"]];
    page1a.titleIconPositionY = self.view.frame.size.height / 2.0f - page1a.titleIconView.frame.size.height / 2.0f;
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"You'll need a DreamHost API key";
    page2.desc = @"Create one with the DreamHost Web Panel.\rpanel.dreamhost.com/index.cgi?tree=home.api\rCome back and use it with DH Bot.";
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onboard-key"]];
    page2.titleIconPositionY = self.view.frame.size.height / 2.0f - page2.titleIconView.frame.size.height / 2.0f;

    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"DH Bot securely stores your keys";
    page3.desc = @"Your key and command information is stored by DH Bot in local, encrypted files. All network traffic with DreamHost uses HTTPS.";
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onboard-lock"]];
    page3.titleIconPositionY = self.view.frame.size.height / 2.0f - page3.titleIconView.frame.size.height / 2.0f;
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Ad supported, no in-app purchases";
    page4.desc = @"DH Bot is free to use. There's no premium version of the application or locked out features.\r\rThat's all. You're ready to go!";
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"onboard-free"]];
    page4.titleIconPositionY = self.view.frame.size.height / 2.0f - page4.titleIconView.frame.size.height / 2.0f;
    
    NSArray* pages = @[page1, page1a, page2, page3, page4];

    // Font sizes and colors
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    [EAIntroPage setFontForAllTitles:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]
                           withColor:[UIColor blackColor]
                           withYPosition:(screenHeight - 60.0f)
                           withPages:pages];
    [EAIntroPage setFontForAllDescriptions:[UIFont fontWithName:@"HelveticaNeue" size:13.0]
                                 withColor:[UIColor blackColor]
                                 withYPosition:140.0f
                                 withPages:pages];

    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:pages];

    // Setup page controller properties
    intro.pageControl.currentPageIndicatorTintColor = [[DHMController sharedInstance] mainWindow].tintColor;
    intro.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];

    // Setup other properties
    [intro setBackgroundColor:[UIColor whiteColor]];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

#pragma EAIntroDelegate Messages (and segue)

-(void)introDidFinish:(EAIntroView *)introView
{
    [[DHMController sharedInstance] onboardingViewed];
    [self performSegueWithIdentifier:@"onboardToMainSegue" sender:self];
}

@end
