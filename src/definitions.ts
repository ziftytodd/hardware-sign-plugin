export interface HardwareSignPluginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
