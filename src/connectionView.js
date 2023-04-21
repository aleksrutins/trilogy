import GObject from 'gi://GObject'
import Gtk from 'gi://Gtk'
import { Connection } from './connection.js'

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
                    Connection
                ),
            },
            Template: 'resource:///com/rutins/Trilogy/connectionView.ui'
        }, this)
    }

    get connection() {
        return this._connection ?? new Connection('No Connection Selected', '');
    }

    set connection(conn) {
        if(this._connection == conn) return;
        this._connection = conn;
        this.notify('connection');
    }

    refreshConnection() {
        const conn = this.connection;

        if(!conn.connected) {

        }
    }
}
