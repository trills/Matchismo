//
//  Card.m
//  Matchismo
//
//  Created by Jenny Tsai on 12/3/13.
//  Copyright (c) 2013 Jenny Tsai. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score =1;
            
        }
    }
    
    return score;
}

@end
