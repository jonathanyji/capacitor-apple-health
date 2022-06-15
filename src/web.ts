import { WebPlugin } from '@capacitor/core';

export class HealthkitWeb extends WebPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async authorize(options: {
    write: string[];
    read: string[];
  }): Promise<{ permission: string }> {
    throw this.unavailable('Not implemented on web.');
  }
  async isAvailable(): Promise<{ result: string }> {
    throw this.unavailable('Not implemented on web.');
  }
  async getWorkouts(results: any): Promise<{ result: string }> {
    throw this.unavailable('Not implemented on web.');
  }
  async getSleep(results: any): Promise<{ result: string }> {
    throw this.unavailable('Not implemented on web.');
  }
  async getMenstrualFlow(results: any): Promise<{ result: string }> {
    throw this.unavailable('Not implemented on web.');
  }
  async isPermissionGranted(): Promise<{ isGranted: string }> {
    throw this.unavailable('Not implemented on web.');
  }
}
