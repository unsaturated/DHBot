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

#import "DHMBaseCommand.h"

/**
 * Command to request a size change for the PS. Resize the memory of a 
 * Dreamhost PS. You are limited to 30 resizes per day per VPS -- use 
 * them wisely! A Service token will also be returned.'
 * TODO : viability of size change counter??
 */
@interface DHMSetSizePsCommand : DHMBaseCommand

@end
