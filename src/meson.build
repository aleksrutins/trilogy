pkgdatadir = join_paths(get_option('datadir'), meson.project_name())
gnome = import('gnome')

src_res = gnome.compile_resources('com.rutins.Trilogy.src',
  'com.rutins.Trilogy.src.gresource.xml',
  gresource_bundle: true,
  install: true,
  install_dir: pkgdatadir,
)

blueprints = custom_target('blueprints',
  input: files(
    'gtk/help-overlay.blp',
    'window.blp',
    'connectionPreview.blp',
    'addConnectionDialog.blp',
    'connectionView.blp'
  ),
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)

data_res = gnome.compile_resources('com.rutins.Trilogy.data',
  'com.rutins.Trilogy.data.gresource.xml',
  gresource_bundle: true,
  install: true,
  dependencies: blueprints,
  install_dir: pkgdatadir,
)

bin_conf = configuration_data()
bin_conf.set('GJS', find_program('gjs').full_path())
bin_conf.set('PACKAGE_VERSION', meson.project_version())
bin_conf.set('PACKAGE_NAME', meson.project_name())
bin_conf.set('prefix', get_option('prefix'))
bin_conf.set('libdir', join_paths(get_option('prefix'), get_option('libdir')))
bin_conf.set('datadir', join_paths(get_option('prefix'), get_option('datadir')))
bin_conf.set('resource_path', '/com/rutins/Trilogy')

configure_file(
  input: 'com.rutins.Trilogy.in',
  output: 'com.rutins.Trilogy',
  configuration: bin_conf,
  install: true,
  install_dir: get_option('bindir')
)
