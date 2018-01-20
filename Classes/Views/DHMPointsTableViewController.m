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

#import "DHMPointsTableViewController.h"
#import "DHMPointsTableCell.h"
#import "DHMController.h"
#import "DHMStoreHelper.h"

@interface DHMPointsTableViewController ()
{
    NSArray* _products;
    BOOL _failedToLoadProductsDueToNetwork;
}
@end

// One static cell with the Available Points for the user
const NSUInteger NUMBER_STATIC_CELLS = 1;

// Two sections - one for Available points, one for Purchase Points
const NSInteger NUMBER_TABLE_SECTIONS = 2;

@implementation DHMPointsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        _failedToLoadProductsDueToNetwork = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Points", @"Page header for the view-controller to display points and purchase additional points.");
    [self refreshControlCreate];
    
    AFNetworkReachabilityStatus start = [RKObjectManager sharedManager].HTTPClient.networkReachabilityStatus;
    if([self updateUIforNetworkStatus:start])
    {
        // Network reachable so begin first load
        [self.refreshControl beginRefreshing];
        [self reloadProductsAndTable];
    }
    
    // Previous check is for immediate update - the following block is for *changes* to that status
    [[RKObjectManager sharedManager].HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         [self updateUIforNetworkStatus:status];
     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Subscribe to point changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsChangedHandler) name:PTS_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointsChangedHandler) name:PTS_REMOVED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseOngoing) name:IAP_PURCHASE_INPROG_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseFailed) name:IAP_PURCHASE_FAILED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseSucceeded) name:IAP_PURCHASE_SUCCESS_NOTIFICATION object:nil];
    
    // Ensure static point count is always up-to-date
    [self pointsChangedHandler];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Unsubscribe from point notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_ADDED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PTS_REMOVED_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IAP_PURCHASE_INPROG_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IAP_PURCHASE_FAILED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IAP_PURCHASE_SUCCESS_NOTIFICATION object:nil];
}

-(void) refreshControlCreate
{
    // Create or restore the control
    if(!self.refreshControl)
    {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(reloadProductsAndTable) forControlEvents:UIControlEventValueChanged];
    }
}

-(void) refreshControlTeardown
{
    // Disable refreshing and remove object
    [self.refreshControl removeTarget:self action:@selector(reloadProductsAndTable) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl endRefreshing];
    self.refreshControl = nil;
}

#pragma mark - Purchasing Behavior

-(void) purchaseOngoing
{
    [self refreshControlTeardown];
}

-(void) purchaseFailed
{
    [self refreshControlCreate];
    [self reloadLocalDataAndTable];
}

-(void) purchaseSucceeded
{
    [self refreshControlCreate];
    [self reloadLocalDataAndTable];
}


#pragma mark - Points Change Handler

-(void) pointsChangedHandler
{
    // Points are in Section 0
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Loading and Reloading

- (void)reloadProductsAndTable
{
    // Wipe out current product list and try again
    _products = nil;
    
    [[DHMStoreHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products)
    {
        if(success)
        {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

-(void) reloadLocalDataAndTable
{
    if(_products)
    {
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // One section for the static cell (available points)
    // A second section for points available from the store
    return NUMBER_TABLE_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionCount = 0;
    
    // Number of static cells plus the count of products from StoreKit
    switch (section)
    {
        case 0:
            sectionCount = NUMBER_STATIC_CELLS;
            break;
        case 1:
            sectionCount = _products.count;
        default:
            break;
    }
    
    return sectionCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* sectionHeader;
    
    // Number of static cells plus the count of products from StoreKit
    switch (section)
    {
        case 0:
            sectionHeader = NSLocalizedString(@"Your Points", @"Header for the table section that specifies user's point quantity");
            break;
        case 1:
            sectionHeader = NSLocalizedString(@"Additional Points", @"Header for the table section that shows point options for purchase");
        default:
            break;
    }
    
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    NSString *cellIdentifier = nil;
    
    if (indexPath.section == 0)
    {
        // Static cell
        cellIdentifier = @"CurrentPointsCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];
        [cell.detailTextLabel setText:[NSNumber numberWithUnsignedInteger:[DHMController sharedInstance].pointsAvailable].stringValue];
    }
    else
    {
        // Dynamic cell
        cellIdentifier = @"PurchasePointsCell";
        [tableView registerNib:[UINib nibWithNibName:@"DHMNibPointsTableCell" bundle:nil] forCellReuseIdentifier:@"PurchasePointsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        DHMPointsTableCell* pointCell = (DHMPointsTableCell*)cell;
        [pointCell setupCellWithProduct:(SKProduct*)[_products objectAtIndex:indexPath.row]];
    }

    return (UITableViewCell*)cell;
}

#pragma mark - Network Status Updates

/**
 Checks detailed status of network.
 @param status Provided by AFNetworking
 @return YES if reachable
 */
-(BOOL) updateUIforNetworkStatus:(AFNetworkReachabilityStatus)status
{
    if ( (status == AFNetworkReachabilityStatusNotReachable) || (status == AFNetworkReachabilityStatusUnknown) )
    {
        _failedToLoadProductsDueToNetwork = YES;
        [self updateUIforNetworkProblem];
        return NO;
    }
    else if( (status == AFNetworkReachabilityStatusReachableViaWiFi) || (status == AFNetworkReachabilityStatusReachableViaWWAN))
    {
        // Reload the points available for purchase
        if(_failedToLoadProductsDueToNetwork)
        {
            _failedToLoadProductsDueToNetwork = NO;
            [self reloadProductsAndTable];
        }
    }
    
    return YES;
}

-(void) updateUIforNetworkProblem
{
    [[DHMController sharedInstance] reportNetworkError];
}

-(NSArray*) testProductArray
{
    NSDictionary* prod1 = @{@"points":@400, @"price": @0.99};
    NSDictionary* prod2 = @{@"points":@800, @"price": @1.99};
    NSDictionary* prod3 = @{@"points":@1500, @"price": @2.99};
    NSDictionary* prod4 = @{@"points":@2000, @"price": @3.99};
    NSDictionary* prod5 = @{@"points":@3000, @"price": @4.99};
    NSDictionary* prod6 = @{@"points":@10000, @"price": @19.99};
    
    return [NSArray arrayWithObjects:prod1, prod2, prod3, prod4, prod5, prod6, nil];
}

@end
