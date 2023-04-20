import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import { Connection } from './connection.js';

export class ConnectionPreview extends Gtk.Box {
    static {
        GObject.registerClass({
            GTypeName: "TrilogyConnectionPreview",
            Properties: {
                'connection': GObject.ParamSpec.object(
                    'connection',
                    'Connection',
                    'The connection to preview',
                    GObject.ParamFlags.READWRITE | GObject.ParamFlags.CONSTRUCT,
                    Connection.$gtype
                )
            },
            Template: "resource:///com/rutins/Trilogy/connectionPreview.ui"
        }, this)
    }

    constructor(conn) {
        super({ 'connection': conn });
    }
}
