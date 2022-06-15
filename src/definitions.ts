export interface HealthkitPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  authorize(options: {
    write: string[];
    read: string[];
  }): Promise<{ permission: string }>;
  isAvailable(): Promise<{ result: string }>;
  getWorkouts(results: any): Promise<{ result: string }>;
  getSleep(results: any): Promise<{ result: string }>;
  getMenstrualFlow(results: any): Promise<{ result: string }>;
  isPermissionGranted(): Promise<{ isGranted: string }>;
}
