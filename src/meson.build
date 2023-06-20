trilogy_sources = [
  'main.vala',
  'application.vala',
  'window.vala',
  'data/connection.vala'
]

trilogy_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.2'),
  dependency('kaste-0.2')
]

trilogy_sources += gnome.compile_resources('trilogy-resources',
  'trilogy.gresource.xml',
  c_name: 'trilogy'
)

executable('trilogy', trilogy_sources,
  dependencies: trilogy_deps,
       install: true,
)
