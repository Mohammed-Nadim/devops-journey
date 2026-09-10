
## Day 11: Linux Text Processing
- **grep**: Filtered specific error logs from application output.
- **awk**: Extracted dynamic column values ($2, $3, $6) for structured reporting.
- **sed**: Performed inline text replacement for log masking and configuration updates.

## Mini Project: System Health Audit & Automated Backup Suite
- Integrated Observium health check (`nc`), disk parsing (`awk`), error log extraction (`grep`/`awk`), and IP masking (`sed`).
- Generated compressed system backup archives (`.tar.gz`) with git-ignored audit logs.

## Day 13: Automation with Linux Cron Jobs
- Defined automated schedule (`30 22 * * *` at 10:30 PM) for `system_health_backup.sh`.
- Created log redirection for Cron stdout/stderr.
