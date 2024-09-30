%{ for name, config in kftray ~}
${name}:
%{ if name == "alertmanager" ~}
  enabled: true
%{ endif ~}
  service:
    annotations:
      "kftray.app/enabled": "true"
      "kftray.app/configs": "${config.alias}-${config.local_port}-${config.target_port}"
%{ endfor ~}
