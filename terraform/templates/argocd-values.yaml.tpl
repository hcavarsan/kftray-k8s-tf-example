%{ for name, config in kftray ~}
${name}:
  service:
    annotations:
      "kftray.app/enabled": "true"
      "kftray.app/configs": "${config.alias}-${config.local_port}-${config.target_port}"
%{ endfor ~}
