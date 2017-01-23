#!/sbin/sh

#Build config file
CONFIGFILE="/tmp/anykernel/ramdisk/init.zetsubou.rc"

echo "" >> $CONFIGFILE
echo "on boot" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#S2W" >> $CONFIGFILE
echo "write /sys/android_touch/sweep2wake  4" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#DT2W" >> $CONFIGFILE
echo "write /sys/android_touch/doubletap2wake  0" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#S2S" >> $CONFIGFILE
echo "write /sys/android_touch/sweep2sleep 3" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "on property:sys.boot_completed=1" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#set I/O scheduler" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/rq_affinity 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/bdi/min_ratio 5" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#set frequencies" >> $CONFIGFILE
echo "#a53 max" >> $CONFIGFILE
echo "chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $CONFIGFILE
echo "chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1401600" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#gpu" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 100000000" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 465000000" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#Display & Sound" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"223 223 255"\" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 271" >> $CONFIGFILE
echo "write /sys/kernel/sound_control/headphone_gain \"4 4"\" >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#enable laptop mode" >> $CONFIGFILE
echo "write /proc/sys/vm/laptop_mode 1" >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#disable core control and enable msm thermal" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/parameters/enabled Y" >> $CONFIGFILE
