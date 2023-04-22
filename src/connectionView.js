import GObject from 'gi://GObject'
import Gtk from 'gi://Gtk'
import Adw from 'gi://Adw'
import Tlg from 'gi://Tlg'

export class ConnectionView extends Adw.Bin {
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
                'show-start-title-buttons': GObject.ParamSpec.boolean(
                    'show-start-title-buttons',
                    'Show Start Title Buttons',
                    'Whether the headerbar should show the start title buttons',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    false
                )
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

    get show_start_title_buttons() {
        return this._show_start_title_buttons ?? false;
    }

    set show_start_title_buttons(sstb) {
        if(this._show_start_title_buttons == sstb) return;
        this._show_start_title_buttons = sstb;
        this.notify('show-start-title-buttons');
    }

    refreshConnection() {
        const conn = this.connection;

        if(!conn.connected) {
            conn.ensure();
        }
    }
}
