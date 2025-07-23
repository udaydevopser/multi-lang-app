{{/*
Expand the name of the chart.
*/}}
{{- define "my-multi-lang-app.name" -}}
{{- default .Chart.Name .Values.application.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If name is too long, we get a hash.
*/}}
{{- define "my-multi-lang-app.fullname" -}}
{{- if .Values.application.name }}
{{- printf "%s" (include "my-multi-lang-app.name" .) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.application.name }}
{{- if contains $name .Release.Name }}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart-specific labels
*/}}
{{- define "my-multi-lang-app.labels" -}}
helm.sh/chart: {{ include "my-multi-lang-app.name" . }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "my-multi-lang-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}