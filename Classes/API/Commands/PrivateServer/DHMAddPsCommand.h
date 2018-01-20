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
 * Command to request a server be added. Schedule the creation of 
 * a new DreamHost PS to your account (currently may take a day or
 * more to actually complete). This will reserve a name for your 
 * new PS and return it in the Data section. A Service token will 
 * also be returned.
 */
@interface DHMAddPsCommand : DHMBaseCommand

@end
