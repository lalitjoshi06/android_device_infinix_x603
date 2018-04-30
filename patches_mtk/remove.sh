#!/bin/bash
cd ../../../..
cd system/sepolicy
git apply --reverse -v ../../device/infinix/x603/patches_mtk/system_sepolicy.patch
cd ../..
cd frameworks/av
cd ..
cd native
git apply --reverse -v ../../device/infinix/x603/patches_mtk/frameworks_native.patch
cd ..
cd base
cd ..
cd opt/telephony
cd ../../..
cd packages/apps/Snap
git apply --reverse -v ../../../device/infinix/x603/patches_mtk/snap.patch
cd ..
cd FMRadio
git apply --reverse -v ../../../device/infinix/x603/patches_mtk/fmradio.patch
cd ../../..
cd system/netd
cd ../..
cd vendor/cmsdk
git apply --reverse -v ../../device/infinix/x603/patches_mtk/vendor_cmsdk.patch
cd ../..
