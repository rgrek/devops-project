{{/*
voting-app generic label
*/}}
{{- define "voting-app.labels" -}}
app: {{ .Chart.Name }}
{{- end }}

{{/*
voting-app postgres labels
*/}}
{{- define "voting-app.postgres.labels" -}}
name: postgres-pod
app: {{ .Chart.Name }}
{{- end }}

{{/*
voting-app redis labels
*/}}
{{- define "voting-app.redis.labels" -}}
name: redis-pod
app: {{ .Chart.Name }}
{{- end }}

{{/*
voting-app worker labels
*/}}
{{- define "voting-app.worker.labels" -}}
name: worker-pod
app: {{ .Chart.Name }}
{{- end }}

{{/*
voting-app result labels
*/}}
{{- define "voting-app.result.labels" -}}
name: result-app-pod
app: {{ .Chart.Name }}
{{- end }}

{{/*
voting-app voting labels
*/}}
{{- define "voting-app.voting.labels" -}}
name: voting-app-pod
app: {{ .Chart.Name }}
{{- end }}