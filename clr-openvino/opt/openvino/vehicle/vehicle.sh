#!/bin/bash -e

target=CPU
MODEL_PATH=/opt/openvino/intel_models

`dirname $0`/security_barrier_camera_demo -d $target -d_va $target -d_lpr $target \
	-m "$MODEL_PATH/vehicle-license-plate-detection-barrier-0106.xml" \
	-m_va "$MODEL_PATH/vehicle-attributes-recognition-barrier-0039.xml" \
	-m_lpr "$MODEL_PATH/license-plate-recognition-barrier-0001.xml" \
	-r -no_show \
	-i $1
