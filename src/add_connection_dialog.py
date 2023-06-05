from gi.repository import Gtk, Adw, GObject, Tlg

@Gtk.Template(resource_path='/com/rutins/Trilogy/add-connection-dialog.ui')
class AddConnectionDialog(Adw.Window):
    __gtype_name__ = 'TrilogyAddConnectionDialog'
    __gsignals__ = {
        'add_connection': (GObject.SIGNAL_RUN_LAST, GObject.TYPE_NONE, (Tlg.Connection,))
    }

    name_entry = Gtk.Template.Child()
    url_entry = Gtk.Template.Child()

    valid = GObject.Property(type=bool, default=False)

    def __init__(self, main_window):
        super().__init__(transient_for=main_window, modal=True)
        self.validate_input()
        
    @Gtk.Template.Callback()
    def cancel_clicked(self, *args):
        self.close()
    
    @Gtk.Template.Callback()
    def add_clicked(self, *args):
        self.emit('add-connection', Tlg.Connection(
            name=self.name_entry.get_text(),
            url=self.url_entry.get_text()
        ))
        self.close()
    
    @Gtk.Template.Callback()
    def validate_input(self, *args):
        name: str = self.name_entry.get_text()
        url: str = self.url_entry.get_text()
        failed = False

        if name == '':
            failed = True
            self.name_entry.add_css_class('error')
        else:
            self.name_entry.remove_css_class('error')

        if Tlg.protocol_for_uri(url) == Tlg.Protocol.UNKNOWN:
            failed = True
            self.url_entry.add_css_class('error')
        else:
            self.url_entry.remove_css_class('error')
        
        self.props.valid = not failed
