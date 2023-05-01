from gi.repository import Gtk, GObject, Tlg

@Gtk.Template(resource_path = "/com/rutins/Trilogy/connectionPreview.ui")
class ConnectionPreview(Gtk.Box):
    __gtype_name__ = 'TrilogyConnectionPreview'
    __gsignals__ = {
        'selected': (GObject.SIGNAL_RUN_LAST, GObject.TYPE_NONE, (Tlg.Connection,))
    }

    _conn: Tlg.Connection

    connection = GObject.Property(type=Tlg.Connection, flags=GObject.ParamFlags.READWRITE|GObject.ParamFlags.CONSTRUCT)

    def __init__(self, conn: Tlg.Connection):
        super().__init__(connection=conn)

    def do_clicked(self, *args):
        self.emit('selected', self.props.connection)
    
