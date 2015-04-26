//
//  Server.m
//  myVultr
//
//  Created by zhangyuan on 1/29/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Server.h"

@implementation Server

-(NSString*) bandwidth {
    if (self.currentBandwidthGb && self.allowedBandwidthGb) {
        return [NSString stringWithFormat:@"%@ / %@", self.currentBandwidthGb , self.allowedBandwidthGb];
    } else {
        return nil;
    }
    
}

@end