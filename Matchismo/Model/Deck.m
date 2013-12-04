//
//  Deck.m
//  Matchismo
//
//  Created by Jenny Tsai on 12/3/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards
{
    // lazy instantiation lecture 2 pg 9
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
   if (atTop) {
       [self.cards insertObject:card atIndex:0];
   } else {
       [self.cards addObject:card] ;
   }
}


- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}


@end
