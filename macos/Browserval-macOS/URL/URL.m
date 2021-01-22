#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(URLModule, RCTEventEmitter)

RCT_EXTERN_METHOD(openUrl: (NSString)url withAppName:(NSString)appName)

@end
