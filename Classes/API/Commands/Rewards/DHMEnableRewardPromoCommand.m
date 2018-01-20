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

#import "DHMEnableRewardPromoCommand.h"

@implementation DHMEnableRewardPromoCommand

+(NSString*) command { return DHM_REW_ENABLE_CODE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Enable Promo Code", @"Enables Promomotional/Rewards Code - the command name itself");
        mCommandDesc = NSLocalizedString(@"Enables a promo code", @"Enables a promotional/rewards code");
        mRunningText = NSLocalizedString(@"Enabling code...", @"In-progress text for enabling a promotional/rewards code");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 2;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * code : desired promo code must be 3-16 characters, only letters or numbers, and not be numbers only
 */
-(NSArray*) acceptableParameters { return @[@"code"]; }

-(BOOL) requiresGuid { return YES; }

@end
