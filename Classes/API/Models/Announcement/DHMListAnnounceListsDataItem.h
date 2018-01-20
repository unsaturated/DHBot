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

#import "DHMBaseData.h"

/**
 Data that represents an announcement list.
 */
@interface DHMListAnnounceListsDataItem : DHMBaseData

/**
 Gets the account ID.
 */
@property (nonatomic, copy) NSNumber* accountId;

/**
 Gets the announcement list reference name.
 */
@property (nonatomic, copy) NSString* listname;

/**
 Gets the announcement list domain.
 */
@property (nonatomic, copy) NSString* domain;

/**
 Gets the announcement list readable name.
 */
@property (nonatomic, copy) NSString* name;

/**
 Gets the announcement list start date.
 */
@property (nonatomic, copy) NSDate* startDate;

/**
 Gets the maximum number of bounces.
 */
@property (nonatomic, copy) NSNumber* maxBounces;

/**
 Gets the number of subscribers.
 */
@property (nonatomic, copy) NSNumber* numberSubscribers;

@end
