import GObject from 'gi://GObject'
import Gtk from 'gi://Gtk'
import Tlg from 'gi://Tlg'

export class ConnectionView extends Gtk.Box {
    static {
        GObject.registerClass({
            GTypeName: 'TrilogyConnectionView',
            Properties: {
                'connection': GObject.ParamSpec.object(
                    'connection',
                    'Connection',
                    'The connection to view',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    Tlg.Connection
                ),
            },
            Template: 'resource:///com/rutins/Trilogy/connectionView.ui'
        }, this)
    }

    get connection() {
        return this._connection ?? Tlg.Connection.new('No Connection Selected', '');
    }

    set connection(conn) {
        if(this._connection == conn) return;
        this._connection = conn;
        this.notify('connection');
        this.refreshConnection();
    }

    refreshConnection() {
        const conn = this.connection;

        if(!conn.connected) {
            conn.ensure();
        }
    }
}
