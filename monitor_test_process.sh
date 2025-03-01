#!/bin/bash

# Лог-файл
LOG_FILE="/var/log/monitoring.log"

# URL для мониторинга
MONITORING_URL="https://test.com/monitoring/test/api"

# Имя процесса
PROCESS_NAME="test"

if pgrep -x "$PROCESS_NAME" > /dev/null; then
	# Процесс запущен и теперь мы отправляем запрос
	if curl -s -o /dev/null -w "%{http_code}" "$MONITORING_URL"; then
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME запущен, запрос на $MONITORING_URL успешно отправлен." >> "$LOG_FILE"
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Процесс $PROCESS_NAME запущен, но запрос на $MONITORING_URL не удался." >> "$LOG_FILE"
	fi
else
	# Процесс не запущен
	:
fi