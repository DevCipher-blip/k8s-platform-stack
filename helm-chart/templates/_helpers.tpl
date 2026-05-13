{{- define "oms.secretName" -}}
{{- default .Values.auth.secretName .Values.auth.existingSecret -}}
{{- end -}}

{{- define "oms.restrictedContainer" -}}
allowPrivilegeEscalation: false
capabilities:
  drop: ["ALL"]
{{- end -}}
