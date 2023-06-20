trilogy_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'connection-preview.vala',
  'connection-view.vala',
  'add-connection-dialog.vala',
  'data/connection.vala'
]

trilogy_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
  dependency('kaste-0.2'),
  dependency('json-glib-1.0'),
  dependency('gee-0.8')
]

subdir('util')
subdir('data')

trilogy_sources += gnome.compile_resources('trilogy-resources',
  'trilogy.gresource.xml',
  c_name: 'trilogy'
)

executable('trilogy', trilogy_sources,
  dependencies: trilogy_deps,
       install: true,
)
