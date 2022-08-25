#!/system/bin/sh
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

# Set Activity Manager's max. cached app number -> 160 (instead of the default 32 (or even lower 24):
sleep 300
[ $(getprop ro.build.version.release) -gt 9 ] && /system/bin/device_config put activity_manager max_phantom_processes 2147483647 ; /system/bin/device_config put activity_manager max_cached_processes 160 || settings put global activity_manager_constants max_cached_processes=160
