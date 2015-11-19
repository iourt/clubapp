/**
 * SaveImage.h
 */

#import <Cordova/CDV.h>

@interface SaveImage : CDVPlugin
{
    NSString* callbackId;
}

@property (nonatomic, copy) NSString* callbackId;

- (void)fromUrl:(CDVInvokedUrlCommand*)command;

@end
