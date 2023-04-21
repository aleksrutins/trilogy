import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import Tlg from 'gi://Tlg';

export class ConnectionPreview extends Gtk.Button {
    static {
        GObject.registerClass({
            GTypeName: "TrilogyConnectionPreview",
            Properties: {
                'connection': GObject.ParamSpec.object(
                    'connection',
                    'Connection',
                    'The connection to preview',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    Tlg.Connection
                )
            },
            Signals: {
                'selected': {
                    param_types: [Tlg.Connection]
                }
            },
            Template: "resource:///com/rutins/Trilogy/connectionPreview.ui"
        }, this)
    }

    get connection() {
        return this._connection ?? null;
    }

    set connection(conn) {
        if(this._connection == conn) return;
        this._connection = conn;
        this.notify('connection');
    }

    constructor(conn) {
        super({ 'connection': conn });
    }

    on_clicked() {
        this.emit('selected', this.connection);
    }
}
