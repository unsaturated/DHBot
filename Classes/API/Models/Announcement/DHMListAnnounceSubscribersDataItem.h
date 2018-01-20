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

@interface DHMListAnnounceSubscribersDataItem : DHMBaseData

/**
 Gets the subscribers e-mail address.
 */
@property (nonatomic, copy) NSString* email;

/**
 Gets whether the subscriber has confirmed their subscription.
 */
@property (nonatomic, copy) NSNumber* confirmed;

/**
 Gets the date the user subscribed.
 */
@property (nonatomic, copy) NSDate* subscribeDate;

/**
 Gets the subscriber's actual name.
 */
@property (nonatomic, copy) NSString* name;

/**
 Gets the number of bounces/rejections.
 */
@property (nonatomic, copy) NSNumber* numberBounces;

@end
