//
//  Common.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/24/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (Common *)sharedInstance
{
    static Common *sharedInstance_ = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance_ = [[Common alloc] init];
        //  sharedInstance_.appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    });
    
    return sharedInstance_;
}

+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

-(BOOL)isNullString:(NSString*)_inputString
{
    NSString *InputString=_inputString;
    
    //InputString=[NSString stringWithFormat:@"%@",_inputString];
    if( (InputString == nil) ||(InputString ==(NSString *)[NSNull null])||([InputString isEqual:nil])||([InputString length] == 0)||([InputString isEqualToString:@""])||([InputString isEqualToString:@"(NULL)"])||([InputString isEqualToString:@"<NULL>"])||([InputString isEqualToString:@"<null>"]||([InputString isEqualToString:@"(null)"])||([InputString isEqualToString:@""]))
       
       )
        return YES;
    else
        return NO ;
}

- (void) showOnlyAlert:(NSString*)title Msg:(NSString*)message
{
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
}

@end
