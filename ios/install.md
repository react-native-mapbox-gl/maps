# iOS Installation

## Using CocoaPods

To install with CocoaPods, add the following to your `Podfile`:

```
  # Flexbox Layout Manager Used By React Native
  pod 'yoga', :path => '../node_modules/react-native/ReactCommon/yoga/Yoga.podspec'

  # React Native
  pod 'React', path: '../node_modules/react-native', subspecs: [
    # Comment out any unneeded subspecs to reduce bundle size.
    'Core',
    'DevSupport',
    'RCTActionSheet',
    'RCTAnimation',
    'RCTBlob',
    'RCTCameraRoll',
    'RCTGeolocation',
    'RCTImage',
    'RCTNetwork',
    'RCTPushNotification',
    'RCTSettings',
    'RCTText',
    'RCTVibration',
    'RCTWebSocket',
    'RCTLinkingIOS'
  ]

  # Mapbox
  pod 'react-native-mapbox-gl', :path => '../node_modules/@react-native-mapbox/maps'
```

Then run `pod install` and rebuild your project.

## Manual Installation

### Add Native Mapbox SDK Framework

Select your project in the `Project navigator`. Click `General` tab then add `node_modules/@react-native-mapbox/maps/ios/Mapbox.framework` to `Embedded Binaries`. :collision: **Important, make sure you're adding it to general -> `Embedded Binaries` :collision:**

Click 'Add other' to open the file browser and select Mapbox.framework.

![](https://s3.systemlevel.com/docs-public/addother.png)

Select the 'Copy items if needed' checkbox.

![](https://s3.systemlevel.com/docs-public/copyitems.png)

After adding Mapbox.framework it should be listed in your Embedded Binaries:

![](https://s3.systemlevel.com/docs-public/embeddedbinaries.png)

<!-- ![](https://cldup.com/s4U3JfS_-l.png) -->


### Add React Native Mapbox SDK Files
In Xcode's `Project navigator`, right click on the `Libraries` folder ➜ `Add Files to <...>`. Add `node_modules/@react-native-mapbox/maps/ios/RCTMGL.xcodeproj`.

![](https://s3.systemlevel.com/docs-public/addfilesto.png)


Then in Xcode navigate to `Build Phases` click on it and you should see `Link Binary with Libraries`, we need to add `libRCTMGL.a`.

![](https://s3.systemlevel.com/docs-public/buildphases.png)

After you add 'libRCTMGL.a' it should be listed as such:

![](https://s3.systemlevel.com/docs-public/buildphasesadd.png)


### Add Framework Header Search Paths
In the `Build Settings` of your application target search for `FRAMEWORK_SEARCH_PATHS`. 

![](https://s3.systemlevel.com/docs-public/frameworksearch.png)

Add `$(PROJECT_DIR)/../node_modules/@react-native-mapbox/maps/ios` non-recursive to your `Framework Search Paths`.

![](https://s3.systemlevel.com/docs-public/frameworksearchadd.png)

**Important** If there is a select input under `Debug` line, choose `Any iOS SDK`.

### Add Run Script

In the `Build Phases` tab, click the plus sign and then `New Run Script Phase`.

![](https://cldup.com/jgt8p_dHjD.png)

Open the newly added `Run Script` and paste:

```bash
 "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Mapbox.framework/strip-frameworks.sh"
```

![](https://s3.systemlevel.com/docs-public/runscript.png)

Checkout the [example application](/example/README.md) to see how it's configured for an example.
