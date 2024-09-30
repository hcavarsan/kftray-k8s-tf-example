%{ for name, config in kftray ~}
%{ if name == "grafana" ~}
service:
  annotations:
    "kftray.app/enabled": "true"
    "kftray.app/configs": "${config.alias}-${config.local_port}-${config.target_port}"
%{ else ~}
${name}:
  service:
    annotations:
      "kftray.app/enabled": "true"
      "kftray.app/configs": "${config.alias}-${config.local_port}-${config.target_port}"
%{ endif ~}
%{ endfor ~}
