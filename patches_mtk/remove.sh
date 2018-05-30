#!/bin/bash
cd ../../../..
cd system/core
git apply --reverse -v ../../device/infinix/x603/patches_mtk/system_core.patch
cd ../..
cd bionic
git apply --reverse -v ../device/infinix/x603/patches_mtk/bionic.patch
cd ..
cd system/sepolicy
git apply --reverse -v ../../device/infinix/x603/patches_mtk/system_sepolicy.patch
cd ../..
cd frameworks/av
git apply --reverse -v ../../device/infinix/x603/patches_mtk/frameworks_av.patch
cd ..
cd native
git apply --reverse -v ../../device/infinix/x603/patches_mtk/frameworks_native.patch
cd ..
cd base
git apply --reverse -v ../../device/infinix/x603/patches_mtk/frameworks_base.patch
cd ..
cd opt/telephony
git apply --reverse -v ../../../device/infinix/x603/patches_mtk/frameworks_opt_telephony.patch
cd ../../..
cd packages/apps/Snap
git apply --reverse -v ../../../device/infinix/x603/patches_mtk/snap.patch
cd ..
cd FMRadio
git apply --reverse -v ../../../device/infinix/x603/patches_mtk/fmradio.patch
cd ../../..
cd system/netd
git apply --reverse -v ../../device/infinix/x603/patches_mtk/system_netd.patch
cd ../..
cd vendor/cmsdk
git apply --reverse -v ../../device/infinix/x603/patches_mtk/vendor_cmsdk.patch
cd ../..
