//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jenny Tsai on 12/3/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int matchthree = FALSE;

    // in three card mode
    for (PlayingCard *card in otherCards){
        
        if (card.rank == self.rank) {
            score += 4;
            
            if (matchthree == TRUE) {
                // give more points;
                score += 4;
            }
            matchthree = TRUE;
        } else if ([card.suit isEqualToString:self.suit]){
            score += 1;
            matchthree = TRUE;

            if (matchthree == TRUE) {
                // give more points;
                score += 1;
            }
        
        }
    }
    
    matchthree = FALSE;

    return score;
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide the setter AND getter

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
