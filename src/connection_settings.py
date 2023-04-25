import os

from gi.repository import GObject, Gtk, Adw, Tlg, Kaste

@Gtk.Template(resource_path='/com/rutins/Trilogy/connection_settings.ui')
class ConnectionSettings(Adw.Window):
    __gtype_name__ = 'TrilogyConnectionSettings'
    
    _wnd = None
    _bucket = Kaste.Bucket.new('com.rutins.Trilogy.connections', False)

    connection = GObject.Property(type=str)

    def __init__(self, main_window, connection: str):
        super().__init__(transient_for=main_window, modal=True)
        self._wnd = main_window
        self.props.connection = connection

    @Gtk.Template.Callback()
    def _delete_clicked(self, *args):
        dlg = Adw.MessageDialog.new(self, 'Delete Connection?', None)
        dlg.props.body = 'Are you sure you want to delete the connection {0}?'.format(self.props.connection)
        dlg.add_response('cancel', 'Cancel')
        dlg.add_response('delete', 'Delete')
        dlg.set_response_appearance('delete', Adw.ResponseAppearance.DESTRUCTIVE)
        dlg.set_default_response('cancel')
        dlg.set_close_response('cancel')
        dlg.choose(None, self._delete_response, self)
    
    def _delete_response(self, dialog, result, _self):
        response = dialog.choose_finish(result)
        if response == 'delete':
            os.remove(self._bucket.get_resource_path(self.props.connection))
            self.close()
            self._wnd.reload_connections()