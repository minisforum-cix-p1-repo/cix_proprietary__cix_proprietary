#!/bin/bash
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/wireless/cfg80211.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/protected_memory_allocator.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/memory_group_manager.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/mali_kbase.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/rtl_btusb.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/rtl_wlan.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/aipu.ko
insmod /lib/modules/6.6.10-cix-build-generic/extra/amvx.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/drivers/hid/uhid.ko
modprobe btusb

insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/netfilter/x_tables.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/ipv4/netfilter/ip_tables.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/ipv4/netfilter/iptable_nat.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/ipv4/netfilter/nf_defrag_ipv4.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/ipv6/netfilter/nf_defrag_ipv6.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/lib/libcrc32c.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/netfilter/nf_conntrack.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/netfilter/nf_nat.ko
insmod /lib/modules/6.6.10-cix-build-generic/kernel/net/netfilter/xt_MASQUERADE.ko

#Install intel ice pcie network driver
modprobe ice

ln -s /dev/dma_heap/reserved /dev/dma_heap/linux,cma

if [[ ! -s  /etc/machine-id ]]; then
dbus-uuidgen > /var/lib/dbus/machine-id
ln -sf /var/lib/dbus/machine-id /etc/machine-id
fi



video_devices=($(ls /dev/video* 2>/dev/null | sort -V))

if [ ${#video_devices[@]} -eq 1 ]; then
ln -s "${video_devices[0]}" /dev/video-cixdec0
elif [ ${#video_devices[@]} -eq 0 ]; then
echo "Not found /dev/video*"
else
max_device="${video_devices[-2]}"
ln -s "$max_device" /dev/video-cixdec0
fi
