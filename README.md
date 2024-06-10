# Пример организации окружения для разработки конфигурации Datareon Platform

## Структура репозитория

### Каталог "build"

> В каталоге размещаются архивы конфигураций

### Каталог "devConfig"

> В каталоге размещаются файлы разрабатываемой конфигурации

### Каталог "devData"

> В каталоге размещаются рабочие данные службы Datareon platform

### Файл "developerConfig.json"

> Конфигурационный файл запускаемого кластера Datareon platform

### Скрипты

| Имя | Описание |
| --- | -------- |
| build.ps1 | Собирает конфигурацию из каталога "devConfig" в архив в каталоге "build". Использует "7z.exe" |
| clearCache.ps1 | Очищает серверный кэш в каталоге рабочих данных "devData" |
| restar.ps1 | Перезапускает службу Datareon Platform. Принимает параметр `[bool] $clearCache = $false` - если передан флаг `$true(1)`, тогда в промежутке, между остаовкой и запуском службы производится очистка серверного кэша (по умолчанию `$false`). |
| run.ps1 | Запускает Datareon Platform в локальном режиме - НЕ в режиме службы. Принимает параметр `[string] $configFileName` - имя файла с конфигурацией кластера (по умолчанию `"developerConfig.json"`). Используется для запуска нескольких экземпляров Datareon Platform на одном компьютере |
| start.ps1 | Запускает службу Datareon Platform |
| status.ps1 | Выводит статус службы Datareon Platform |
| stop.ps1 | Останавливает службу Datareon Platform |

## Подготовка окружения

### Используемое ПО

> 1. Datareon Platform
> 2. Visual Studio Code
> 3. Git

### Настройка окружения

> Без прав администратор

```ps
# Создадим рабочий каталог и перейдем в него
$workSpace = 'C:\Datareon\Platform'
  
New-Item -Force -ItemType Directory -Path $workSpace
  
Set-Location $workSpace
  
# Клонируем репозиторий конфигурации и переключимся на ветку разработки
git clone https://github.com/justppn/datareon_platform.git .
git checkout -B "dev" "origin/dev"
```

> С правами локального администратора

```ps
# Остановим службу
$serviceName = "DatareonPlatform"
  
sc.exe stop $serviceName
  
# Установим разрешения на перезапуск службы для группы DomainUsers
$perm = sc.exe sdshow $serviceName
sc.exe sdset $serviceName ($perm -replace "D:","D:(A;;RPWPDTCR;;;DU)")
  
# Установим дополнительные параметры для запуска Datareon Platform в режиме разработчика
$binPath = "C:\Program Files (x86)\Datareon\Platform\DatareonPlatformService.exe"
$configPath = $workSpace + "\developerConfig.json"
 
$binPath = """" + $binPath + " developer -developerConfig=" + $configPath + " -asService"""
 
sc.exe config $serviceName binPath=$binPath
  
# Запустим службу
sc.exe start $serviceName
```
