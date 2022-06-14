import {registerPlugin} from '@capacitor/core';

import type {HealthkitPlugin} from './definitions';

const Healthkit = registerPlugin<HealthkitPlugin>('Healthkit', {
  web: () => import('./web').then(m => new m.HealthkitWeb()),
});

export * from './definitions';
export default Healthkit;
