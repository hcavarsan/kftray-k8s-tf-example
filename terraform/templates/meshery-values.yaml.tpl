%{ for name, config in kftray ~}
service:
  type: ClusterIP
  annotations:
    "kftray.app/enabled": "true"
    "kftray.app/configs": "${config.alias}-${config.local_port}-${config.target_port}"
%{ endfor ~}
