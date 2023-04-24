from gi.repository import Gtk, Adw, Kaste, Tlg

from .connection_view import ConnectionView
from .connection_preview import ConnectionPreview
from .add_connection_dialog import AddConnectionDialog

@Gtk.Template(resource_path='/com/rutins/Trilogy/window.ui')
class TrilogyWindow(Adw.ApplicationWindow):
    __gtype_name__ = 'TrilogyWindow'

    leaflet = Gtk.Template.Child()
    connections_list = Gtk.Template.Child()
    view_stack = Gtk.Template.Child()
    navbar = Gtk.Template.Child()

    bucket = Kaste.Bucket.new('com.rutins.Trilogy.connections', False)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.reload_connections()
    
    def reload_connections(self):
        while (preview := self.connections_list.get_first_child()) != None:
            self.connections_list.remove(preview)
        
        contents = self.bucket.list_contents()

        while (item := contents.next_file()) != None:
            name = item.get_name()
            data = self.bucket.read(Tlg.Connection, name)
            preview = ConnectionPreview(data)
            self.connections_list.append(preview)
    
    def actually_add_connection(self, conn):
        self.bucket.write(conn.name, conn)
        self.reload_connections()

    def add_connection(self):
        dlg = AddConnectionDialog(self)
        dlg.connect('add-connection', self.actually_add_connection)
    
    @Gtk.Template.Callback()
    def navigate(self, _list, row, _data):
        print('Navigating: ', row)
        if row != None:
            conn = row.get_child().connection()
            if self.view_stack.get_child_by_name('connection-' + conn.name) is None:
                page = ConnectionView()
                page.props.connection = conn
                sstb_expr = Gtk.PropertyExpression.new(Adw.Leaflet, None, 'folded')
                sstb_expr.bind(page, 'show-start-title-buttons', self.leaflet)
                page.connect('go-to-navigation', self.go_to_navigation)
                self.view_stack.add_named(page, 'connection-' + conn.name)
            self.view_stack.set_visible_child_name('connection-' + conn.name)
        else:
            self.view_stack.set_visible_child_name('welcome')

    @Gtk.Template.Callback()
    def go_to_navigation(self):
        self.leaflet.set_visible_child(self.navbar)