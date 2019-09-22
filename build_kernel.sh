#!/bin/bash
#
# Chery-pick Kernel Build Script 
# Coded by defir97 @2019
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
clear
# Init Fields
QS_V_FRONT=1
QS_V_BACK=0
QS_VERSION=v$QS_V_FRONT.$QS_V_BACK
QS_VARIANT=grandpplte
QS_DATE=$(date +%Y%m%d)
QS_TOOLCHAIN=/home/defir97/Android/Toolchain/UBERTC-arm-eabi-4.8/bin/arm-eabi-
QS_JOBS=`grep processor /proc/cpuinfo|wc -l`
QS_DIR=$(pwd)
# Init Methods
#BUILD_ZIMAGE
	echo "----------------------------------------------"
	echo "Building zImage for $QS_VARIANT..."
	echo " "
	export ARCH=arm
        DTS=arch/arm/boot/dts
	export CROSS_COMPILE=$QS_TOOLCHAIN
	export LOCALVERSION=-Cherry-pick_Kernel-$QS_VERSION-$QS_VARIANT-$QS_DATE
	make grandpplte_00_defconfig
        make mt6737t_grandpplte_ltn_open_01.dtb mt6737t_grandpplte_ltn_open_02.dtb mt6737t_grandpplte_ltn_open_03.dtb mt6737t_grandpplte_ltn_open_04.dtb
        make -j4
	echo " "
# Make DT.img
./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048
# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb
