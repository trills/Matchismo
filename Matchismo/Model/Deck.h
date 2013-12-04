//
//  Deck.h
//  Matchismo
//
//  Created by Jenny Tsai on 12/3/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
