## Android RAM management fixes by crok - Magisk 20.4+

## Activity Manager cached app number increaser + BService number increaser

## Find every info here:

## Telegra.ph posts by crok
https://telegra.ph/Telegraph-posts-by-crok-05-28

## Related documents:

## Xiaomi Redmi Note 4X and memory management
https://telegra.ph/Xiaomi-Redmi-Note-4X-and-memory-management-05-28

## Fine tuning an Android system
https://telegra.ph/Fine-tuning-an-Android-system-04-20

## Details

First of all: this is not a "classic" Magisk module.
This is a set of commands to apply to modify the ActivityManager's behavior and disable MIUI PeriodicCleaner - but not systemless.. and not changing any files.. it is changing / adding system parameters when installed (and after reboot) and removes them when uninstalled.
The values can be changed via ADB, too, so in case you want to apply the changes you can run the content of service.sh and in case you want to remove them you can run the content of uninstall.sh (Everything is [written here, too](https://logout.hu/bejegyzes/crok/android_activitymanager_am_es_memoriahasznalat_jav.html), it's hungarian but hope you get what the commands are doing - if you don't please don't go further!)

~~## Virtual memory "tweaks"  --  kind of obsolate since Android 10..~~
```
# Virtual memory tweaks
stop perfd
echo '100' > /proc/sys/vm/swappiness
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo '100' > /proc/sys/vm/vfs_cache_pressure
echo '128' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '128' > /sys/block/mmcblk1/queue/read_ahead_kb
echo '8000' > /proc/sys/vm/min_free_kbytes
echo '0' > /proc/sys/vm/oom_kill_allocating_task
echo '5' > /proc/sys/vm/dirty_ratio
echo '20' > /proc/sys/vm/dirty_background_ratio
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '21816,29088,36360,43632,50904,65448' > /sys/module/lowmemorykiller/parameters/minfree
rm /data/system/perfd/default_values
start perfd
sleep 20

```

THIS is still quite handy though!
https://gist.github.com/agnostic-apollo/dc7e47991c512755ff26bd2d31e72ca8
Credits goes to https://github.com/agnostic-apollo/ and all who were involved.

```
# Set Activity Manager's max. cached app number -> 160 (instead of the default 32 (or even lower 24):
# https://gist.github.com/agnostic-apollo/dc7e47991c512755ff26bd2d31e72ca8
## Android 9 and below:
settings put global activity_manager_constants max_cached_processes=160
## Android 10 and above:
/system/bin/device_config put activity_manager max_phantom_processes 2147483647
/system/bin/device_config put activity_manager max_cached_processes 160

## Combined:
[ $(getprop ro.build.version.release) -gt 9 ] && /system/bin/device_config put activity_manager max_phantom_processes 2147483647 ; /system/bin/device_config put activity_manager max_cached_processes 160 || settings put global activity_manager_constants max_cached_processes=160
```

## Android 9 and below: Increasing ActivityManager's cached app number + number of BService processes
Obsolate - removed - in case you need them you can use MagiskHidePropsConfig to add them systemlessly (or simply add them to build.prop):
```
ro.sys.fw.bg_apps_limit=128
ro.vendor.qti.sys.fw.bg_apps_limit=128
ro.vendor.qti.sys.fw.bservice_enable=true
ro.vendor.qti.sys.fw.bservice_age=10000
ro.vendor.qti.sys.fw.bservice_limit=128
```


These can be easily set via other tools or apps that support init.d scripts and build.prop editing but I use Magisk anyway.. so.. why not using it to do the job properly - with successful SafetyNet test    ( :


*NOTE: If you are using MIUI ROM you may have to disable MIUI optimization and MIUI memory optimization because it resets most of these settings. If you use any app that tweaks settings above please uninstall or at least disable them to run and ruin the module's settings. Disabling MIUI opt. may cause permission and other kind of strange issues (like inability to attach files, etc). So.. I did tell you about it.*



_Quite honestly speaking I wrote this for myself only,
publicated long time ago and.. haters, please don't ever even install it,
I'm not advertising this module anywhere so please use other mods, hyped high AF.
This one is not doing fine-tuning by dynamic smart scripting or anything,
just my own oldschool settings coming from my of Android and Linux experiences..
I tried to document everything, if you disagree with any of the settings then either
do not install the mod or fork it and set it to your own value - freedom to do it is yours, too.
This module is rather a proof of concept for myself than a module for everybody. It works very well for me._
