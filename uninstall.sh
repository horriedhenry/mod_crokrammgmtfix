#!/system/bin/sh

# Delete Activity Manager's max. cached app number variable and system will use the Activity Manager's default settings:
[ $(getprop ro.build.version.release) -gt 9 ] && /system/bin/device_config reset trusted_defaults activity_manager ; /system/bin/device_config put activity_manager max_phantom_processes default ; /system/bin/device_config put activity_manager max_cached_processes default || settings delete global activity_manager_constants
