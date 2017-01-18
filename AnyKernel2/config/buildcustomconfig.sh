#!/sbin/sh

#Build config file
CONFIGFILE="/tmp/anykernel/ramdisk/init.zetsubou.rc"

echo "on boot" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#S2W" >> $CONFIGFILE
SR=`grep "item.1.1" /tmp/aroma/gest.prop | cut -d '=' -f2`
SL=`grep "item.1.2" /tmp/aroma/gest.prop | cut -d '=' -f2`
SU=`grep "item.1.3" /tmp/aroma/gest.prop | cut -d '=' -f2`
SD=`grep "item.1.4" /tmp/aroma/gest.prop | cut -d '=' -f2`

if [ $SL = 1 ]; then
  SL=2
fi
if [ $SU == 1 ]; then
  SU=4
fi
if [ $SD == 1 ]; then
  SD=8
fi  

S2W=$(( SL + SR + SU + SD ))
echo "write /sys/android_touch/sweep2wake " $S2W >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#DT2W" >> $CONFIGFILE
DT2W=`grep "item.1.5" /tmp/aroma/gest.prop | cut -d '=' -f2`
echo "write /sys/android_touch/doubletap2wake " $DT2W >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#S2S" >> $CONFIGFILE
S2S=`grep selected.0 /tmp/aroma/s2s.prop | cut -d '=' -f2`
if [ $S2S = 2 ]; then
  echo "write /sys/android_touch/sweep2sleep 1" >> $CONFIGFILE
elif [ $S2S = 3 ]; then
  echo "write /sys/android_touch/sweep2sleep 2" >> $CONFIGFILE
elif [ $S2S = 4 ]; then
  echo "write /sys/android_touch/sweep2sleep 3" >> $CONFIGFILE
else
  echo "write /sys/android_touch/sweep2sleep 0" >> $CONFIGFILE
fi

echo "" >> $CONFIGFILE
echo "on property:sys.boot_completed=1" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "#set I/O scheduler" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/rq_affinity 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/bdi/min_ratio 5" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#set min/max frequencies" >> $CONFIGFILE
echo "#a53 min" >> $CONFIGFILE
echo "chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $CONFIGFILE
echo "chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $CONFIGFILE
cpu0=`grep selected.1 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 200000" >> $CONFIGFILE
elif [ $cpu0 = 2 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 302000" >> $CONFIGFILE
elif [ $cpu0 = 3 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 400000" >> $CONFIGFILE
elif [ $cpu0 = 4 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 533330" >> $CONFIGFILE
else
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 800000" >> $CONFIGFILE
fi
#
echo "#a53 max" >> $CONFIGFILE
echo "chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $CONFIGFILE
echo "chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $CONFIGFILE
cpu0=`grep selected.2 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1843200" >> $CONFIGFILE
elif [ $cpu0 = 2 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1766400" >> $CONFIGFILE
elif [ $cpu0 = 3 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1612800" >> $CONFIGFILE
elif [ $cpu0 = 4 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1516800" >> $CONFIGFILE
elif [ $cpu0 = 5 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1401600" >> $CONFIGFILE
elif [ $cpu0 = 6 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1363200" >> $CONFIGFILE
else
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1209600" >> $CONFIGFILE
fi
#
echo "#set hotplug" >> $CONFIGFILE
cpu0=`grep selected.3 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "write /sys/module/autosmp/parameters/enabled Y" >> $CONFIGFILE
else
echo "write /sys/module/autosmp/parameters/enabled N" >> $CONFIGFILE
fi

echo "" >> $CONFIGFILE

echo "#set cpu governor" >> $CONFIGFILE
echo "chown system system /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $CONFIGFILE
echo "chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $CONFIGFILE
gov=`grep selected.0 /tmp/aroma/gov.prop | cut -d '=' -f2`
if [ $gov = 1 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor chill" >> $CONFIGFILE
elif [ $gov = 2 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor despair" >> $CONFIGFILE
elif [ $gov = 3 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor impulse" >> $CONFIGFILE
elif [ $gov = 4 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive" >> $CONFIGFILE
elif [ $gov = 5 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor conservative" >> $CONFIGFILE
elif [ $gov = 6 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ondemand" >> $CONFIGFILE
elif [ $gov = 7 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor powersave" >> $CONFIGFILE
elif [ $gov = 8 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor bioshock" >> $CONFIGFILE
else
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor performance" >> $CONFIGFILE
fi

echo "" >> $CONFIGFILE

echo "#GPU" >> $CONFIGFILE
gpu=`grep selected.1 /tmp/aroma/gpu.prop | cut -d '=' -f2`
if [ $gpu = 1 ]; then
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 100000000" >> $CONFIGFILE
else
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 200000000" >> $CONFIGFILE
fi
gpu=`grep selected.2 /tmp/aroma/gpu.prop | cut -d '=' -f2`
if [ $gpu = 1 ]; then
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 620000000" >> $CONFIGFILE
elif [ $gpu = 2 ]; then
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 465000000" >> $CONFIGFILE
else
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 310000000" >> $CONFIGFILE
fi
gpu=`grep selected.3 /tmp/aroma/gpu.prop | cut -d '=' -f2`
if [ $gpu = 1 ]; then
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active Y" >> $CONFIGFILE
else
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active N" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE

echo "#Display & Sound" >> $CONFIGFILE
misc=`grep selected.1 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 2 ]; then
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"223 223 255"\" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 271" >> $CONFIGFILE
elif [ $misc = 3 ]; then
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 256 225"\" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 255" >> $CONFIGFILE
else
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 256 256"\" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 255" >> $CONFIGFILE
fi
misc=`grep selected.2 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 1 ]; then
echo "write /sys/kernel/sound_control/headphone_gain \"4 4"\" >> $CONFIGFILE
fi

echo "" >> $CONFIGFILE

echo "#enable laptop mode" >> $CONFIGFILE
echo "write /proc/sys/vm/laptop_mode 1" >> $CONFIGFILE

echo "" >> $CONFIGFILE

echo "#disable core control and enable msm thermal" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/parameters/enabled Y" >> $CONFIGFILE
