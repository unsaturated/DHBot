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

#import "DHMMainTabBarViewController.h"
#import "DHMController.h"

@interface DHMMainTabBarViewController ()
{
//    NSNumber* _pointsOnBadge;
}
@end

@implementation DHMMainTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //_pointsOnBadge = nil;
        // Custom initialization
    }
    return self;
}

/*
// TODO : Repurpose this for completed service tasks
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsChangedHandler) name:PTS_REMOVED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsChangedHandler) name:PTS_ADDED_NOTIFICATION object:nil];
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITabBarItem* i = nil;
    
    // Set the API key image
    if(self.tabBar.items[KeysTab])
    {
        i = (UITabBarItem*)self.tabBar.items[KeysTab];
        i.image = [UIImage imageNamed:@"key_deselected"];
        i.selectedImage = [UIImage imageNamed:@"key_selected"];
    }
    
    // Set the service image
//    if(self.tabBar.items[ServiceTag])
//    {
//        i = (UITabBarItem*)self.tabBar.items[ServiceTag];
//        i.image = [UIImage imageNamed:@"cloud_deselected"];
//        i.selectedImage = [UIImage imageNamed:@"cloud_selected"];
//    }
    
    // Set the points image
    if(self.tabBar.items[HistoryTab])
    {
        i = (UITabBarItem*)self.tabBar.items[HistoryTab];
        i.image = [UIImage imageNamed:@"points_deselected"];
        i.selectedImage = [UIImage imageNamed:@"points_selected"];
    }
    
    // Initialize the points available
    // TODO : Repurpose this for completed service tasks
    //self.pointsOnBadge = [DHMController sharedInstance].pointsAvailable;
}

/*
// TODO : Repurpose this for completed service tasks
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_REMOVED_NOTIFICATION object:nil];
}
*/

/**
 Handles events from NSNotificationCenter when points are added or removed.
 */
-(void) pointsChangedHandler
{
    // TODO : Repurpose this for completed service tasks
}

/*
// TODO : Repurpose this for completed service tasks
- (void)setPointsOnBadge:(NSUInteger)pointsOnBadge
{
    if(_pointsOnBadge == nil)
    {
        // Nil is considered the initialization value, and the case where no badge should be displayed
        if(pointsOnBadge <= PTS_LOW_WARNING_LEVEL)
        {
            _pointsOnBadge = [NSNumber numberWithUnsignedLong:pointsOnBadge];
            [self.tabBar.items[HistoryTab] setBadgeValue:_pointsOnBadge.stringValue];
        }
    }
    else if(_pointsOnBadge.unsignedIntegerValue != pointsOnBadge)
    {
        if(pointsOnBadge <= PTS_LOW_WARNING_LEVEL)
        {
            // Update the value displayed on the badge
            _pointsOnBadge = [NSNumber numberWithUnsignedLong:pointsOnBadge];
            [self.tabBar.items[HistoryTab] setBadgeValue:_pointsOnBadge.stringValue];
        }
        else if(pointsOnBadge > PTS_LOW_WARNING_LEVEL)
        {
            // Clear the value displayed on the badge
            [self.tabBar.items[HistoryTab] setBadgeValue:nil];
            _pointsOnBadge = nil;
            
        }
    }
}
*/

@end
