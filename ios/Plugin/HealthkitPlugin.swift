import Foundation
import Capacitor
import HealthKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(HealthkitPlugin)
public class HealthkitPlugin: CAPPlugin {
    var healthStore: HKHealthStore = HKHealthStore();
    private let functions = Healthkit()
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve(["value": value])
    }
    
    @objc func isAvailable(_ call: CAPPluginCall) {
        if HKHealthStore.isHealthDataAvailable() {
            return call.resolve(["result": true])
        } else {
            return call.reject("Health data not available")
        }
    }
    
    @objc func authorize(_ call: CAPPluginCall){
        if (HKHealthStore.isHealthDataAvailable()) {
            
            let permission = functions.getPermissionType(call)
            
            healthStore.requestAuthorization(toShare: Set(permission.write), read: Set(permission.read)) {
                (success, error) in
                
                if !success {
                    return call.reject("Could not get permission")
                    
                }
                
                return call.resolve(["permission": true]);
            }
        }
        else {
            return call.reject("Health data not available")
        }
    }
    
    @objc func getWorkouts(_ call: CAPPluginCall){
        
        guard let _startDate = call.options["startDate"] as? String else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? String else {
            call.reject("Must provide endDate")
            return
        }
        
        guard let _sampleNames = call.options["sampleName"] as? String else {
            call.reject("Must provide sampleNames")
            return
        }
        
        let date = functions.formatDate(_startDate, _endDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: date.startDate, end: date.endDate, options: HKQueryOptions.strictStartDate)
        
        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: predicate,
            limit: 0,
            sortDescriptors: nil) { (query, results, error) in
                
                guard let output: [[String: Any]] = self.functions.generateWorkoutOutput(sampleName: _sampleNames, results: results) else {
                    return
                }
                call.resolve(["result": output])
            }
        
        HKHealthStore().execute(query)
        
    }
    
    @objc func getSleep(_ call: CAPPluginCall){
        
        guard let _startDate = call.options["startDate"] as? String else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? String else {
            call.reject("Must provide endDate")
            return
        }
        
        guard let _sampleNames = call.options["sampleName"] as? String else {
            call.reject("Must provide sampleNames")
            return
        }
        
        let date = functions.formatDate(_startDate, _endDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: date.startDate, end: date.endDate, options: HKQueryOptions.strictStartDate)
        
        let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        
        let query = HKSampleQuery(
            sampleType: sleepType,
            predicate: predicate,
            limit: 0,
            sortDescriptors: nil )
        { (query, results, error) -> Void in
            
            guard let output: [[String: Any]] = self.functions.generateSleepOutput(sampleName: _sampleNames, results: results) else {
                return
            }
            call.resolve(["result": output])
        }
        
        healthStore.execute(query)
        
    }
    
    @objc func getMenstrualFlow(_ call: CAPPluginCall){
        
        guard let _startDate = call.options["startDate"] as? String else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? String else {
            call.reject("Must provide endDate")
            return
        }
        
        guard let _sampleNames = call.options["sampleName"] as? String else {
            call.reject("Must provide sampleNames")
            return
        }
        
        let date = functions.formatDate(_startDate, _endDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: date.startDate, end: date.endDate, options: HKQueryOptions.strictStartDate)
        
        let menstrual = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!
        
        let query = HKSampleQuery(
            sampleType: menstrual,
            predicate: predicate,
            limit: 0,
            sortDescriptors: nil )
        { (query, results, error) -> Void in
            
            guard let output: [[String: Any]] = self.functions.generateMenstrualOutput(sampleName: _sampleNames, results: results) else {
                return
            }
            call.resolve(["result": output])
        }
        
        healthStore.execute(query)
        
    }
    
}
