/**
 * SaveImage.m
 */

#import "SaveImage.h"
// #import <Cordova/CDV.h>

@implementation SaveImage
@synthesize callbackId;

- (void) fromUrl:(CDVInvokedUrlCommand*)command
{
	self.callbackId = command.callbackId;

	NSString *url = [command.arguments objectAtIndex:0];
	
	UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
	
	UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	// error;
	if (error != NULL)
	{
		NSLog(@"ERROR: %@",error);
		CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString:error.description];
		[self.webView stringByEvaluatingJavaScriptFromString:[result toErrorCallbackString: self.callbackId]];
	}
	else
	{
		NSLog(@"IMAGE SAVED!");
		CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:@"Image saved"];
		[self.webView stringByEvaluatingJavaScriptFromString:[result toSuccessCallbackString: self.callbackId]];
	}
	
}

- (void)dealloc
{	
	[callbackId release];
    [super dealloc];
}

@end
