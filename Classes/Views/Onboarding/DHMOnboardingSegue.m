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

#import "DHMOnboardingSegue.h"
#import "BannerViewController.h"

@implementation DHMOnboardingSegue

-(void)perform
{
    // Loads the UITabBarController (the primary interface) and wraps it with a banner view
    UIViewController* controller = [[BannerViewController alloc]
                                    initWithContentViewController:[self destinationViewController]];
    
    [[self sourceViewController]
     presentViewController:controller animated:YES completion:^{}];
}

@end
