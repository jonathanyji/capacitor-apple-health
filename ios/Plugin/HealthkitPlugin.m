#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(HealthkitPlugin, "Healthkit",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(isAvailable, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(authorize, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getWorkouts, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getSleep, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getMenstrualFlow, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(isPermissionGranted, CAPPluginReturnPromise);
)
		
