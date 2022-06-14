import {WebPlugin} from '@capacitor/core';

export class HealthkitWeb extends WebPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
