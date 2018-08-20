## Rankmi Test

# Instalación Ejercicio 3

1. `cd ejecicio_3`
2. `bundle install`
3. `rake db:create`
4. `rake db:migrate`

# Uso

- Importar archivo:

1. `rails c`
2. `Importers::FamilyGoals.read('/paht-to-file/0311_326_definicionfamilias.xlsx').import`

- Crear usuario:

1. `rails c`
2. `User.create name: 'Leonardo', world: 'Banco y Filiales', area: 'ZONA CENTRO 1', position: 'EJECUTIVO PERSONAS'`