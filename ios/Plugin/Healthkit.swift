import Foundation
import Capacitor
import HealthKit

@objc public class Healthkit: NSObject {
    var healthStore: HKHealthStore = HKHealthStore();
    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    public func getPermissionType(_ call: CAPPluginCall) -> (read: [HKObjectType], write: [HKSampleType]){
        
        let readList = call.options["read"] as? [String]
        let writeList = call.options["write"] as? [String]
        
        var allowRead = [HKObjectType]()
        var allowWrite = [HKSampleType]()
        
        
        for activity in readList!{
            switch (activity)  {
            case "activity":
                allowRead.append(HKObjectType.workoutType())
            case "sleep":
                allowRead.append(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!)
                break
            case "menstruation":
                allowRead.append(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!)
                break
            default:
                continue
            }
        }
        
        for activity in writeList!{
            switch (activity)  {
            case "activity":
                allowWrite.append(HKObjectType.workoutType())
            case "sleep":
                allowWrite.append(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!)
                break
            case "menstruation":
                allowWrite.append(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.menstrualFlow)!)
                break
            default:
                continue
            }
        }
        
        return (allowRead, allowWrite)
    }
    
    public func generateWorkoutOutput(sampleName: String, results: [HKSample]?) -> [[String: Any]]? {
        var output: [[String: Any]] = []
        
        for result in results! {
            
            guard let sample = result as? HKWorkout else {
                return nil
            }
            
            output.append([
                "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                "id": sample.uuid.uuidString,
                "workoutActivityTypeID": sample.workoutActivityType.rawValue,
                "workoutActivityName": returnWorkoutActivityTypeValueDictionnary(activityType: sample.workoutActivityType),
                "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                "source": sample.sourceRevision.source.name,
                "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
            ])
            
        }
        return output
    }
    
    public func generateSleepOutput(sampleName: String, results: [HKSample]?) -> [[String: Any]]? {
        var output: [[String: Any]] = []
        
        for result in results! {
            
            guard let sample = result as? HKCategorySample else {
                return nil
            }
            
            let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
            let seconds = sample.endDate.timeIntervalSince(sample.startDate)
            let minutes = seconds/60
            
            output.append([
                "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                "id": sample.uuid.uuidString,
                "sleepType": value,
                "minutes": minutes,
                "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                "source": sample.sourceRevision.source.name,
                "sourceBundleId": sample.sourceRevision.source.bundleIdentifier
            ])
        }
        
        return output
    }
    
    public func generateMenstrualOutput(sampleName: String, results: [HKSample]?) -> [[String: Any]]? {
        var output: [[String: Any]] = []
        
        for result in results! {
            
            guard let sample = result as? HKCategorySample else {
                return nil
            }
            
            output.append([
                "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                "id": sample.uuid.uuidString,
                "flowType": returnMenstruationTypeValueDictionary(sample.value),
                "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                "source": sample.sourceRevision.source.name,
                "sourceBundleId": sample.sourceRevision.source.bundleIdentifier
            ])
        }
        
        return output
    }
    
    public func returnMenstruationTypeValueDictionary(_ flowType: Int) -> String{
        
        switch flowType {
        case HKCategoryValueMenstrualFlow.unspecified.rawValue:
            return "unspecified"
            
        case HKCategoryValueMenstrualFlow.light.rawValue:
            return "light"
            
        case HKCategoryValueMenstrualFlow.medium.rawValue:
            return "medium"
            
        case HKCategoryValueMenstrualFlow.heavy.rawValue:
            return "heavy"
            
        case HKCategoryValueMenstrualFlow.none.rawValue:
            return "none"
        default:
            return "none"
        }
        
    }
    
    public func returnWorkoutActivityTypeValueDictionnary(activityType: HKWorkoutActivityType) -> String {
        // from https://github.com/georgegreenoflondon/HKWorkoutActivityType-Descriptions/blob/master/HKWorkoutActivityType%2BDescriptions.swift
        switch activityType {
        case HKWorkoutActivityType.americanFootball:
            return "American Football"
        case HKWorkoutActivityType.archery:
            return "Archery"
        case HKWorkoutActivityType.australianFootball:
            return "Australian Football"
        case HKWorkoutActivityType.badminton:
            return "Badminton"
        case HKWorkoutActivityType.baseball:
            return "Baseball"
        case HKWorkoutActivityType.basketball:
            return "Basketball"
        case HKWorkoutActivityType.bowling:
            return "Bowling"
        case HKWorkoutActivityType.boxing:
            return "Boxing"
        case HKWorkoutActivityType.climbing:
            return "Climbing"
        case HKWorkoutActivityType.crossTraining:
            return "Cross Training"
        case HKWorkoutActivityType.curling:
            return "Curling"
        case HKWorkoutActivityType.cycling:
            return "Cycling"
        case HKWorkoutActivityType.dance:
            return "Dance"
        case HKWorkoutActivityType.danceInspiredTraining:
            return "Dance Inspired Training"
        case HKWorkoutActivityType.elliptical:
            return "Elliptical"
        case HKWorkoutActivityType.equestrianSports:
            return "Equestrian Sports"
        case HKWorkoutActivityType.fencing:
            return "Fencing"
        case HKWorkoutActivityType.fishing:
            return "Fishing"
        case HKWorkoutActivityType.functionalStrengthTraining:
            return "Functional Strength Training"
        case HKWorkoutActivityType.golf:
            return "Golf"
        case HKWorkoutActivityType.gymnastics:
            return "Gymnastics"
        case HKWorkoutActivityType.handball:
            return "Handball"
        case HKWorkoutActivityType.hiking:
            return "Hiking"
        case HKWorkoutActivityType.hockey:
            return "Hockey"
        case HKWorkoutActivityType.hunting:
            return "Hunting"
        case HKWorkoutActivityType.lacrosse:
            return "Lacrosse"
        case HKWorkoutActivityType.martialArts:
            return "Martial Arts"
        case HKWorkoutActivityType.mindAndBody:
            return "Mind and Body"
        case HKWorkoutActivityType.mixedMetabolicCardioTraining:
            return "Mixed Metabolic Cardio Training"
        case HKWorkoutActivityType.paddleSports:
            return "Paddle Sports"
        case HKWorkoutActivityType.play:
            return "Play"
        case HKWorkoutActivityType.preparationAndRecovery:
            return "Preparation and Recovery"
        case HKWorkoutActivityType.racquetball:
            return "Racquetball"
        case HKWorkoutActivityType.rowing:
            return "Rowing"
        case HKWorkoutActivityType.rugby:
            return "Rugby"
        case HKWorkoutActivityType.running:
            return "Running"
        case HKWorkoutActivityType.sailing:
            return "Sailing"
        case HKWorkoutActivityType.skatingSports:
            return "Skating Sports"
        case HKWorkoutActivityType.snowSports:
            return "Snow Sports"
        case HKWorkoutActivityType.soccer:
            return "Soccer"
        case HKWorkoutActivityType.softball:
            return "Softball"
        case HKWorkoutActivityType.squash:
            return "Squash"
        case HKWorkoutActivityType.stairClimbing:
            return "Stair Climbing"
        case HKWorkoutActivityType.surfingSports:
            return "Surfing Sports"
        case HKWorkoutActivityType.swimming:
            return "Swimming"
        case HKWorkoutActivityType.tableTennis:
            return "Table Tennis"
        case HKWorkoutActivityType.tennis:
            return "Tennis"
        case HKWorkoutActivityType.trackAndField:
            return "Track and Field"
        case HKWorkoutActivityType.traditionalStrengthTraining:
            return "Traditional Strength Training"
        case HKWorkoutActivityType.volleyball:
            return "Volleyball"
        case HKWorkoutActivityType.walking:
            return "Walking"
        case HKWorkoutActivityType.waterFitness:
            return "Water Fitness"
        case HKWorkoutActivityType.waterPolo:
            return "Water Polo"
        case HKWorkoutActivityType.waterSports:
            return "Water Sports"
        case HKWorkoutActivityType.wrestling:
            return "Wrestling"
        case HKWorkoutActivityType.yoga:
            return "Yoga"
            // iOS 10
        case HKWorkoutActivityType.barre:
            return "Barre"
        case HKWorkoutActivityType.coreTraining:
            return "Core Training"
        case HKWorkoutActivityType.crossCountrySkiing:
            return "Cross Country Skiing"
        case HKWorkoutActivityType.downhillSkiing:
            return "Downhill Skiing"
        case HKWorkoutActivityType.flexibility:
            return "Flexibility"
        case HKWorkoutActivityType.highIntensityIntervalTraining:
            return "High Intensity Interval Training"
        case HKWorkoutActivityType.jumpRope:
            return "Jump Rope"
        case HKWorkoutActivityType.kickboxing:
            return "Kickboxing"
        case HKWorkoutActivityType.pilates:
            return "Pilates"
        case HKWorkoutActivityType.snowboarding:
            return "Snowboarding"
        case HKWorkoutActivityType.stairs:
            return "Stairs"
        case HKWorkoutActivityType.stepTraining:
            return "Step Training"
        case HKWorkoutActivityType.wheelchairWalkPace:
            return "Wheelchair Walk Pace"
        case HKWorkoutActivityType.wheelchairRunPace:
            return "Wheelchair Run Pace"
            // iOS 11
        case HKWorkoutActivityType.taiChi:
            return "Tai Chi"
        case HKWorkoutActivityType.mixedCardio:
            return "Mixed Cardio"
        case HKWorkoutActivityType.handCycling:
            return "Hand Cycling"
            // iOS 13
        case HKWorkoutActivityType.discSports:
            return "Disc Sports"
        case HKWorkoutActivityType.fitnessGaming:
            return "Fitness Gaming"
            // Catch-all
        default:
            return "Other"
        }
    }
    
    public func formatDate(_ startDate: String, _ endDate: String) -> (startDate: Date?, endDate: Date?){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let _startDate = dateFormatter.date(from: startDate)
        let _endDate = dateFormatter.date(from: endDate)
        
        return (_startDate, _endDate)
    }
    
    public func checkPermissionSet(_ call: CAPPluginCall, _ permissionType: HKObjectType) -> String{
        if (healthStore.authorizationStatus(for: permissionType) == .notDetermined ) {
            return "notDetermined"
        } else if (healthStore.authorizationStatus(for: permissionType) == .sharingDenied ){
            return "sharingDenied"
        } else {
            return "sharingAuthorized"
        }
    }
    
}
