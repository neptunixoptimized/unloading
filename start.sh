#!/bin/bash

cleanup_files() {
    echo "Очистка файлов дампа..."
    rm -f jitdump*.dmp javacore*.txt core*.dmp Snap*.trc
}

cleanup_files

plugins_dir="plugins"
spark_dir="spark"
mkdir -p "$plugins_dir"
mkdir -p "/home/container/plugins/spark"
cd "$plugins_dir"

echo "Скачивание плагина HibernateX.jar..."
curl -s -L -o "HibernateX.jar" "https://github.com/neptunixoptimized/unloading/raw/main/HibernateX.jar" > /dev/null
if [ -f "HibernateX.jar" ]; then
    echo "HibernateX.jar успешно скачался!"
else
    echo "Плагин HibernateX.jar не скачался!"
fi

echo "Скачивание Spark.jar..."
curl -s -L -o "Spark.jar" "https://github.com/neptunixoptimized/unloading/raw/main/spark-1.10.74-bukkit.jar" > /dev/null
if [ -f "Spark.jar" ]; then
    echo "Spark.jar успешно скачался!"
    cd /home/container/plugins/spark
    curl -s -L -o "config.json" "https://github.com/neptunixoptimized/unloading/raw/main/sparkconfig.json"
    echo "Изменена конфигурация плагина Spark!"
else
    echo "Плагин spark-1.10.74-bukkit.jar не скачался!"
fi

cd ..

echo "Подтверждение Minecraft EULA (https://www.minecraft.net/en-us/eula)"
curl -s -L -o "eula.txt" "https://github.com/neptunixoptimized/unloading/raw/main/eula.txt" > /dev/null
if [ -f "eula.txt" ]; then
    echo "Minecraft EULA успешно подтверждена!"
else
    echo "Minecraft EULA не подтверждена!"
fi

echo '_____   __            _____              _____        '
echo '___  | / /______________  /____  ___________(_)___  __'
echo '__   |/ /_  _ \__  __ \  __/  / / /_  __ \_  /__  |/_/'
echo '_  /|  / /  __/_  /_/ / /_ / /_/ /_  / / /  / __>  <  '
echo '/_/ |_/  \___/_  .___/\__/ \__,_/ /_/ /_//_/  /_/|_|  '
echo '              /_/                                     '

cd /home/container

java -Xms128M -XX:MaxRAMPercentage=95.0 -XX:ConcGCThreads=2 -XX:ParallelGCThreads=2 -XX:+UseSerialGC -DPaper.IgnoreJavaVersion=true -Dfml.readTimeout=1024 -Dfml.queryResult=confirm -Dlog4j2.formatMsgNoLookups=true -Dterminal.jline=false -Dterminal.ansi=true -DIReallyKnowWhatIAmDoingISwear=true -Duser.timezone=Europe/Moscow -jar -Dfile.encoding=UTF-8 server.jar nogui
