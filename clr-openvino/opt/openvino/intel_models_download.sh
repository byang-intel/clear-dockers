#!/bin/bash

mkdir -p /opt/openvino/intel_models
for m in person-detection-action-recognition-0004 \
		license-plate-recognition-barrier-0001 \
		vehicle-license-plate-detection-barrier-0106 \
		vehicle-attributes-recognition-barrier-0039 \
		face-detection-adas-0001 \
		landmarks-regression-retail-0009 \
		face-reidentification-retail-0095 \
		person-detection-action-recognition-0003 \
	; do
	curl -k https://download.01.org/openvinotoolkit/2018_R5/open_model_zoo/$m/FP32/$m.xml -o /opt/openvino/intel_models/$m.xml
	curl -k https://download.01.org/openvinotoolkit/2018_R5/open_model_zoo/$m/FP32/$m.bin -o /opt/openvino/intel_models/$m.bin
done
