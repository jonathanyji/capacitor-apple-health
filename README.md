# capacitor-apple-health

Capacitor plugin for Apple HealthKit

## Install

```bash
npm install capacitor-apple-health
npx cap sync
```

**** iOS Prerequisite setup ****

1. Add HealthKit to your Xcode project (section signing & capabilities)
2. Go to App (Root), Info tab
3. Add new key and ADD 

    a)Read Permission by selecting
        "Privacy - Health Share Usage Description"
        Value: $HEALTH_READ_PERMISSION

    b)Write permission by selecting
        "Privacy - Health Update Usage Description"
        Value: $HEALTH_WRITE_PERMISSION

4. Go to Signing & Capabilities Healthkit tab
    a) Tick "Clinical Health Records"
    b) Tick "Background Delivery"
    

**** To install the plugin locally ****

    1. Copy the plugin folder into the project
    2. Cd to monorepo/frontend/app
    3. npm i /Users/jonathan/Documents/Source/monorepo/frontend/app/src/capacitor-plugin-healthkit


**** To use the plugin in .ts file ****

    // Usage of import (locate the index file in the Healthkit plugin)
    import Healthkit from '../../../../capacitor-plugin-healthkit/src/index';

    // To call and use the function from the plugin
    const {result} = await Healthkit.getWorkouts(test);



"ionic cap sync ios" To copy contents to Xcode to run on emulator


## API

<docgen-index>

* [`echo(...)`](#echo)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------

</docgen-api>
