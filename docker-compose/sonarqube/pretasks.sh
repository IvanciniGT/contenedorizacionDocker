# Ejecutar como administrador
# Ojo para jugar vale... Estos cambios no son persistentes a nivel de SO
sysctl -w vm.max_map_count=524288
sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192
