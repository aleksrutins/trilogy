from gi.repository import Gtk, Adw, GObject, Tlg

@Gtk.Template(resource_path='/com/rutins/Trilogy/addConnectionDialog.ui')
class AddConnectionDialog(Adw.Window):
    __gtype_name__ = 'TrilogyAddConnectionDialog'
    _valid = False

    name_entry = Gtk.Template.Child()
    url_entry = Gtk.Template.Child()

    def __init__(main_window):
        super.__init__(transient_for=main_window, modal=True)

    @GObject.Property(type=bool, default=False)
    def valid(self) -> bool:
        return self._valid
    
    @valid.setter
    def valid(self, value: bool):
        self._valid = value
    
    @GObject.Signal(arg_types=(Tlg.Connection,))
    def add_connection(self):
        pass
    
    @Gtk.Template.Callback()
    def cancel_clicked(self):
        self.close()
    
    @Gtk.Template.Callback()
    def add_clicked(self):
        self.emit('add-connection', Tlg.Connection(
            name=self.name_entry.get_text(),
            url=self.url_entry.get_text()
        ))
        self.close()
    
    @Gtk.Template.Callback()
    def validate_input(self):
        name: str = self.name_entry.get_text()
        url: str = self.url_entry.get_text()
        failed = False

        if name.find(' ') != -1 or name == '':
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