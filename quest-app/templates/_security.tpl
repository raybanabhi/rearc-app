{{- define "quest.app.pod-security-context" -}}
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
    fsGroup: 1000
    runAsNonRoot: true
{{- end -}}