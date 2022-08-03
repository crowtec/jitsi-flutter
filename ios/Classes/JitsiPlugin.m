#import "JitsiPlugin.h"
#if __has_include(<jitsi/jitsi-Swift.h>)
#import <jitsi/jitsi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jitsi-Swift.h"
#endif

@implementation JitsiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJitsiPlugin registerWithRegistrar:registrar];
}
@end
