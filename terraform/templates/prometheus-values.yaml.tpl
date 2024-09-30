alertmanager:
  enabled: true
  service:
    annotations:
      "kftray.app/enabled": "true"
      "kftray.app/configs": "alertmanager-19093-9093"

server:
  service:
    annotations:
      "kftray.app/enabled": "true"
      "kftray.app/configs": "${kftray_alias}-${kftray_local_port}-${kftray_target_port}"
