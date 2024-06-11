
# Создадим рабочий каталог и перейдем в него
$workSpace = 'C:\Datareon\Platform'
  
New-Item -Force -ItemType Directory -Path $workSpace
  
Set-Location $workSpace

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